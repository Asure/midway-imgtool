# loadimg — Agent Reference

Williams/Midway arcade image loader replacement for the MS-DOS LOAD2/LOADW tool (Williams Electronics Games Inc., 1995). Reads `.lod` script files and `.img` container files, outputs `.tbl`/`.asm`/`.glo`/`.irw` files for TMS34020 GSP hardware.

---

## IMG Container Format

### File Layout

IMG files use a **data-first** layout. The metadata directory is at the end, pointed to by the OSET field:

```
[LIB_HDR 28 bytes][pixel data + palette color data ... ~986KB][IMAGE records at OSET][PAL_REC records]
```

The data section immediately after the header begins with RGB565 palette color values (e.g. `0xff7f`), not struct records.

### LIB_HDR (28 bytes, `#pragma pack(2)`)

| Field   | Type     | Notes |
|---------|----------|-------|
| imgcnt  | uint16   | Total image record count, **including** special `!` records |
| palcnt  | uint16   | Number of palette records |
| oset    | uint32   | File offset to start of IMAGE records |
| version | uint16   | e.g. `0x64e`; old format uses `0x634` |
| seqcnt  | uint16   | Number of sequence (SEQSCR) entries |
| scrcnt  | uint16   | Number of script entries |
| damcnt  | uint16   | Number of damage table entries |
| temp    | uint16   | Magic value `0xabcd` (validation) |
| bufscr  | uint8[4] | |
| spare1-3| uint16   | |

### IMG_REC (50 bytes, `#pragma pack(2)`)

| Field    | Type   | Notes |
|----------|--------|-------|
| name     | char[16] | Sprite name, space-padded. `!` prefix = special record (palette ref, stand-in) |
| flags    | uint16 | e.g. `0x4` |
| anix     | int16  | Animation anchor X |
| aniy     | int16  | Animation anchor Y |
| w        | uint16 | Pixel buffer width (8bpp stride width, multiple of 4) |
| h        | uint16 | Pixel buffer height |
| palnum   | uint16 | Index into palette table |
| oset     | uint32 | File offset to pixel data (8bpp, row stride = `(w+3)&~3`) |
| data_p   | uint32 | Runtime data pointer (zero in file) |
| lib      | uint16 | Library index |
| anix2    | int16  | |
| aniy2    | int16  | |
| aniz2    | int16  | |
| frm      | uint16 | |
| pttblnum | int16  | Point table index; `-1` = none |
| opals    | uint16 | Usually `0xffff` |

**Special records:** Records whose names start with `!` (e.g. `!STAND2`, `!STAND4`) are counted in `imgcnt` but excluded from the image list. `n_special` is determined by counting leading `!`-prefix records; `n_images = imgcnt - n_special`.

**Critical offset rule:** `pal_start = oset + imgcnt * sizeof(IMG_REC)`. Do **not** add `n_special` again — `imgcnt` already includes them. Adding `n_special` was a confirmed bug that produced a 100-byte error (2 records × 50 bytes).

### PAL_REC (26 bytes, `#pragma pack(2)`)

| Field   | Type      | Notes |
|---------|-----------|-------|
| name    | char[10]  | Palette name (e.g. `YOKRED_P`) |
| flags   | uint8     | |
| bitspix | uint8     | Bits per pixel (e.g. 6 or 8) |
| numc    | uint16    | Number of colors |
| oset    | uint32    | File offset to color data |
| data_p  | uint16    | Runtime pointer |
| lib     | uint16    | |
| colind  | uint8     | |
| cmap    | uint8     | |
| spare   | uint16    | |

Color data is RGB565 16-bit values stored inline at `pal->oset`.

### PTTBL (Point Table, `#pragma pack(1)`)

Authoritative layout from `IT/wmpstruc.inc`. Located after PAL_RECs in the file (skip SEQSCR/SCR blocks first when seqcnt/scrcnt > 0).

```c
// PTBOX: all fields unsigned
// X = left edge (pixel column, 0-based)
// Y = top edge (pixel row, 0-based)
// W = box width − left_edge  (= right_x − X, stored as offset not absolute)
// H = box height − top_edge  (= bottom_y − Y, stored as offset not absolute)
typedef struct { uint8_t x, y, w, h; } PTBOX;   // 4 bytes

typedef struct {
    uint16_t flags;
    int16_t  x1, x2, x3;       // PWRD1/2/3 — packed collision / custom data
    int16_t  x_anipt3, y_anipt3, z_anipt3;  // 3rd animation point
    uint16_t id;                // PT3Y / misc
    PTBOX    box[5];            // up to 5 hit/display boxes
    PTBOX    cbox[1];           // collision box
} PTTBL;   // 40 bytes total
```

Each `IMAGE` record has a `pttblnum` field (int16, −1 = no table). This is an index into the full record array (including `!`-prefix special records). To get the PTTBL array index, subtract `n_special`: `pt_idx = pttblnum - n_special`. The LOD never references `!` images, but they consume PTTBL slots normally.

**SEQSCR size** (from wmpstruc.inc, pack 2): `name(16) + flags(2) + num(2) + entry_t(64) + startx(2) + starty(2) + dam(6) + spare(4)` = **98 bytes** per entry. Skip `seqcnt + scrcnt` of these before the PTTBL block.

### Pixel Storage

- Raw 8bpp indexed pixels, row stride = `(w + 3) & ~3` (4-byte alignment)
- Pixel buffer is zero-initialized; stride padding is guaranteed zero
- Maximum palette index determines effective bpp for compression

---

## SIZX / SIZY — Display Window

SIZX is the **compression window width** used by the DMA engine. Defaults to `rec->w`
(proven by YOK_HIT2.IMG test where `pttblnum=-1` gives SIZX=55 = rec->w).

When a PTTBL is present, LOADW derives SIZX from the PTTBL entry at index
`pttblnum - n_special`. Specifically: **SIZX = PTTBL[idx].BOX[1].W**.

The formula `PTTBL[img_idx].BOX[1].X+1` also produces correct values in many cases
because BOX[1].X is typically 1 less than BOX[1].W in the special records.

SIZY defaults to `rec->h`.

## Point Table / PT Pairs — Animation Points

The PTTBL (point table) structure from `wmpstruc.inc` contains:

```
PTTBL: FLAGS(dw) + x1..x3(int16) + X,Y,Z(int16) + ID(dw)    = 16 bytes
       BOX[0..4]: X,Y,W,H(bytes) × 5                          = 20 bytes
       CBOX[0]:   X,Y,W,H(bytes) × 1                          = 4 bytes
Total = 40 bytes
```

### IT Tool display (collision box info)

The IT tool (`itimg.asm` at line 7328) prints collision box data:
```
X_disp = (signed)CBOX.X - ANIX + CBOX.W
Y_disp = (signed)CBOX.Y - ANIY + CBOX.H
W_disp = BOX[1].W + (CBOX.W - CBOX.H)  (no +1, internal format)
H_disp = BOX[1].Y - CBOX.W
```

For Y4AH4A01 this displays: `-21 -106 36 111` (matching user observation).

### TBL PT Pairs (4 animation point pairs)

LOADW outputs 8 values (4 coordinate pairs) as the extra point table data
after the PWRD fields. Verified by matching LOADW output for Y4AH4A01,
Y4AH4A02, and Y4AH4A03 across the YOKOIMG.TBL reference.

When PTTBL x1/x2/x3/X/Y/Z fields are zero (default), LOADW computes them
from the box geometry as follows:

```
PT1 = (CBOX.X-signed - ANIX + CBOX.W,  CBOX.Y-signed - ANIY + CBOX.H)
PT2 = (pt0.BOX[1].W + pt0.CBOX.W - pt0.CBOX.H - 1,
       pt0.BOX[1].Y - pt0.CBOX.W - 1)                     # from PTTBL[0] (!STAND2)
PT3 = (pt.BOX[2].X + 1,
       ANIY - pt.BOX[1].H + pt0.CBOX.H)                    # pt0=PTTBL[0] always
PT4 = (ANIX - pt.BOX[1].W, ANIY - pt.BOX[1].H)
```

Where `pt` = PTTBL[idx] (image's own table at `pttblnum - n_special`)
and `pt0` = PTTBL[0] (!STAND2 special record, always used for shared values).

PT1 and PT2 are **shared** (from the special records' tables). PT3 and PT4
are **per-image** (from the image's own table).

**Verification table:**

| Image      | PT1       | PT2      | PT3      | PT4     |
|------------|-----------|----------|----------|---------|
| Y4AH4A01   | -21,-106  | 35,110   | 21,114   | -7,110  |
| Y4AH4A02   | -21,-106  | 35,110   | 24,94    | -7,90   |
| Y4AH4A03   | -23,-91   | 35,110   | 31,91    | -7,88   |

---

## IRW Binary Format

The IRW is the output container for compressed (or uncompressed) GSP image data.

### Header (0x44 bytes)

| Offset | Content |
|--------|---------|
| 0x00   | ASCII date string (e.g. `"03/14/95"`) |
| 0x20   | image count low byte |
| 0x21   | image count high byte |
| 0x22   | global bpp |
| 0x2e   | `0x02` |
| 0x30–0x33 | total file size (little-endian uint32) |

### Data Section (from offset 0x44)

Continuous bit-packed image data. Images are stored sequentially with no delimiters or padding between them.

- SAG values from the TBL are **bit offsets** into this data section (TMS34010 uses bit-addressable memory)
- Multi-scale images store full → half → quarter resolution sequentially; the next image's SAG starts immediately after the last scale's bits

---

## DMA2 CTRL Word

```
Bits [15:12]  PIX SIZE: 0=8bpp, else = bpp value (e.g. 6 for 6bpp)
Bits [11:10]  TM: trailing-zero multiplier selector (0–3 → ×1,×2,×4,×8)
Bits [9:8]    LM: leading-zero multiplier selector (0–3 → ×1,×2,×4,×8)
Bit  [7]      CMP: 1 = compression enabled (ZON mode)
```

Multiplier values: `mult = 1 << selector` (so LM=1 → ×2, LM=2 → ×4, etc.)

Choose LM/TM selector based on maximum zero run needing to fit in a 4-bit field:
- ≤15 zeros → selector 0 (×1)
- ≤30 zeros → selector 1 (×2)
- ≤60 zeros → selector 2 (×4)
- else      → selector 3 (×8)

---

## Row Compression Format (ZON mode)

Each compressed row = **1 header byte** + **stored pixels** bit-packed LSB-first.

```
Header byte:  [trail_n : 4 bits][lead_n : 4 bits]
```

- `lead_c = lead_n × lm_mult` — leading zero pixels skipped
- `trail_c = trail_n × tm_mult` — trailing zero pixels skipped
- `stored = sizx − lead_c − trail_c` — pixels actually written to the stream

**Invariant:** `lead_c + stored = sizx` when `trail_n = 0` (holds for most early rows).

Pixels are written at `bpp` bits each, LSB first. Total bits per row = `8 + stored × bpp`.

### lead_n Algorithm (running minimum)

The encoder maintains a **running minimum** of leading zeros (within the SIZX window) seen from row 0 to the current row:

```
lead_n = running_min_lead // lm_mult
```

This ensures all rows decoded so far remain valid when lead_n decreases. The reference LOAD2 also appears to use a **look-ahead** of ~3–4 rows for the initial rows (rows 0–2 use a lead_n derived from a future row's minimum), but this optimization only affects compression efficiency, not correctness.

### trail_n Algorithm

Trailing zeros are counted within the SIZX window only. trail_n behavior appears to use segment-based or look-ahead logic distinct from the running-minimum used for lead_n. The current implementation computes trail_n from available headroom (`avail = sizx − lead_c − content`) which produces valid, DMA-decodable output even if not bit-identical to the reference.

### Uncompressed mode (ZOF)

Pixels are packed directly: `bpp` bits each, LSB first, no row header. No lead/trail optimization.

---

## Multi-Scale Encoding

Each image can have 1–4 LOD scales (full, ½, ¼, ⅛). Controlled by `*N` suffix in LOD `---->` lines.

- Scale 0 (full): encoded with ZON compression using the analyzed LM/TM multipliers
- Scales 1–3: encoded **uncompressed** at subsampled resolution (`w/denom × h/denom`), pixel-nearest sampling
- Each scale gets its own SAG offset and CTRL word in the TBL entry

---

## LOD File Format

LOD files are text scripts processed line by line. Lines beginning with `;` or `/` are comments.

### Directives

| Directive | Effect |
|-----------|--------|
| `ZON>`    | Enable zero-run compression |
| `ZOF>`    | Disable zero-run compression |
| `PON>`    | Enable palette output |
| `POF>`    | Disable palette output |
| `XON>`    | Extra zero pixel mode on |
| `XOF>`    | Extra zero pixel mode off |
| `CON>`    | Checksum deduplication on |
| `COF>`    | Checksum deduplication off |
| `MON>`    | (monitor — ignored) |
| `BON>`    | (ignored) |
| `ROM>`    | (ignored) |
| `PPP>N`   | Force N bits per pixel (1–8); auto-detect if omitted |
| `ASM> file` | Set output TBL assembly file |
| `GLO> file` | Set output GLO globals file |
| `***> addr,end,bank` | Set base address for IRW encoding |
| `IHDR field:size,...` | Define image header field layout |
| `filename.IMG`        | Load IMG container file |
| `----> name[:hex][*N],...` | Process named images from current IMG |

### IHDR Fields

`SIZX`, `SIZY`, `SAG`, `CTRL`, `ANIX`, `ANIY`, `PAL`, `ALT`, `PWRD1`, `PWRD2`, `PWRD3`, `PT3Y`, `PT0X`–`PT4Y`

Sizes: `B` (byte), `W` (word, default), `L` (long)

Default IHDR: `SIZX:W,SIZY:W,ANIX:W,ANIY:W,SAG:L,CTRL:W,PAL:L,PWRD1:W,PWRD2:W,PWRD3:W,PT3Y:W`

---

## TBL Output Format (Assembly)

```asm
        .DATA
        .word   <scale_count>
IMAGE_NAME:
        .word   <SIZX>
        .word   <SIZY>
        ...                     ; per IHDR field list
        .long   0<SAG>H
        .word   0<CTRL>H
        .long   <PAL_LABEL>
        ; additional scales (scale 1+):
        .long   0<SAG_S1>H
        .word   0<CTRL_S1>H
```

Palette file (`imgpal.asm`) format:
```asm
PALNAME:
        .word   <numc>
        .word   XXXXH,XXXXH,...  ; 8 RGB565 values per line
```

---

## loadimg Tool — Command Line

```
loadimg <lod_file> [flags]
  /T[=dir]  Build TBL/ASM/GLO table files (optionally to directory)
  /F[=dir]  Build IRW raw file (optionally to directory)
  /X        Skip IRW generation
  /I[=dir]  Source image directory
  /D[=dir]  LOD file directory
  /V        Verbose output
  /E        Dual-banked image memory
  /P        Pad to 4-bit boundary
  /L        Align to 16-bit boundary
  /B        Derive bpp from palette size
  /3        Limit scales to 3
  /A        Append mode for GLO file
```

Output filenames are derived from the LOD file's base name (uppercased):
- `<BASE>IMG.TBL` — image table assembly
- `IMGTBL.GLO` — global symbols
- `IMGPAL.ASM` — palette data
- `<BASE>.IRW` — compressed image binary

### Processing Pipeline

1. **scan_bpp pass** — reads all `---->` image lists, computes global max pixel value → global bpp. Respects `PPP>` override.
2. **process_lod pass** — for each image: analyze compression window (SIZX from PTTBL), choose LM/TM multipliers, encode all rows to IRW bitstream, write TBL entry, write palette if needed.
3. **write_irw** — flush IRW header + bit-packed data to file.

### Key Implementation Notes

- **Two-pass architecture:** bpp determined globally before encoding begins.
- **Case-insensitive IMG loading:** tries original, uppercase, and lowercase filenames, in both `imgdir` and current directory.
- **n_special handling:** special `!` records are identified by scanning leading `!`-prefix records; `n_images = imgcnt − n_special`. The palette offset is `oset + imgcnt × 50` — do NOT add `n_special` again, as `imgcnt` already includes them (confirmed bug: adding it caused a 100-byte overrun).
- **PTTBL offset:** after palettes, skip `seqcnt + scrcnt` SEQSCR blocks (98 bytes each per wmpstruc.inc). PTTBL entries then follow directly.
- **PTTBL indexing:** PTTBL array index = `pttblnum - n_special`. `pttblnum` is an index into the full record array (specials included); subtract `n_special` to get the zero-based PTTBL array position. `n_pttbls = n_images + n_special` to cover all records.
- **SIZX source:** `PTTBL[pttblnum - n_special].BOX[1].W`. When no PTTBL (pttblnum=-1), falls back to `rec->w`. Verified by YOK_HIT2.IMG removal test.
- **PT pairs:** When PTTBL x1/x2/x3 fields are zero, computed from BOX/CBOX geometry (documented in Point Table section above). When non-zero, read directly from PTTBL fields.
- **Running-minimum lead_n:** uses running minimum with 4-row look-ahead for LM/TM selection, matching LOADW's CTRL words. SIZX ≤ 15 forces LM=0/TM=0.
- **IRW bit stream:** LSB-first packing. Each call to `irw_write_bits(val, n)` appends `n` bits starting from the LSB of `val`.
- **SAG in TBL:** stored as the raw `irw_bit` offset at the moment encoding begins for that image. Represents bit position within the IRW data section (TMS34010 bit-addressable). **Do NOT add `base_addr`** — the `***>` address is not included in TBL output; LOADW and LOAD2 both store raw bit offsets.
- **IRW encoding always runs:** even when `/X` skips writing the IRW file, encoding still executes so that SAG offsets and scale CTRLs are computed correctly for TBL output.
- **`g.tbldir` must be set from `/T=` flag** before `process_lod` runs, so that `ASM>` directives inside the LOD redirect to the correct output directory.
- **`write_palette` guards `g.pal_fp`:** if no palette file is open (e.g. `/T` not specified), write_palette returns early rather than crashing.
- **Compression correctness:** current implementation produces 0 pixel decode errors against the source IMG for both test images (118 rows × 34px and 115 rows × 33px). Output is slightly smaller than reference (~5% better compression) due to not replicating LOAD2's look-ahead lead_n heuristic for initial rows.

---

## SEQSCR / Sequence Structures (IMG)

When `seqcnt > 0`, SEQSCR entries appear between the palette records and the PTTBL section. From `wmpstruc.inc` (pack 2):

```
name_s    byte[16]      ; INAMELEN+1
flags     sword         ; 2
num       sword         ; 2
entry_t   dd[16]        ; 64  (16 frame pointers)
startx    sword         ; 2
starty    sword         ; 2
dam       byte[6]       ; 6
spare1    sword         ; 2
spare2    sword         ; 2
Total = 98 bytes
```

Skip `seqcnt` SEQSCR entries then `scrcnt` SEQSCR entries (scripts use the same struct) to reach the PTTBL block. The `num` field is the count of active frames, not the entry array size (always 16 slots allocated).

---

## Reference Files

| File | Description |
|------|-------------|
| `loadimg/src/loadimg.c` | Main implementation (1393 lines) |
| `loadimg/load2.hlp` | Original LOAD2 documentation |
| `loadimg/DMA2.DOC` | DMA2 CTRL word documentation |
| `loadimg/lod/YOK_HIT.IMG` | Reference IMG container (126 images, 4 palettes) |
| `loadimg/build/` | CMake build directory |
| `IT/it.inc` / `IT/wmpstruc.inc` | Assembly struct definitions for IMG format |
| `loadimg/binary/LOADW.EXE` | Original MS-DOS LOADW binary (5/25/94) |
| `loadimg/output/YOKOIMG.TBL` | Reference LOADW YOKO output |
| `loadimg/output2/YOKOTEST.TBL` | Reference LOAD2 YOKOTEST output (03/14/95) |
| `loadimg/output3/BAMIMG.TBL` | Reference LOADW BAM output |

## LOADW Binary Analysis

The LOADW.EXE at `loadimg/binary/LOADW.EXE` is an MS-DOS MZ executable (16-bit x86,
290KB, dated 5/25/94). Entry point: CS=0x0c9a, IP=0x0018. Code segment at file
offset 0x1A00 (416×16).

### COFF Debug Symbols

The binary contains COFF-style debug symbols appended at the end of the file,
revealing C function names and source files. Extracted via `strings`:

- `_create_point_table` at file offset 247675
- `_compute_bpp` at file offset 248804
- `_write_palette`, `_write_row`, `_write_tbl`
- Source files: `load2.c`, `zcom.c`, `emm.c`, `ldbgnd2.c`

The debug symbol addresses use a 4-byte field after the null-terminated name.
For `_create_point_table`, the segment/offset maps to `1000:5BE1` in Ghidra's
memory layout (confirmed by matching disassembly).

### SIZX computation (from BOX[1] references)

The code accesses PTTBL BOX[1] at offsets 0x14 (X), 0x15 (Y), 0x16 (W), 0x17 (H):
- `mov ax,[bx+0x16]` loads BOX[1].W into AX
- `cmpw $0xa,es:[bx+0x16]` — threshold check: if BOX[1].W ≤ 10, special handling

### Format Strings (TBL output)

Located at addresses `4000:7abe`–`4000:7ad9+` in Ghidra (file offsets ~234688–234734).
The cluster contains 5 null-terminated format strings used sequentially:

```
4000:7ac2: "%d"              — scale count
4000:7ac4: "\t.word\t%d,%d"  — PT values 1–2
4000:7ad1: ",%d,%d"          — PT values 3–4 (continuation, no leading tab)
4000:7ad9: "\t.word\t0,0,0,0"— hardcoded default (not used for real PT output)
4000:7ae6: "\t.global\t%s"   — global label
```

### Known issues / TODOs

1. **Scale SAG offsets**: Scale (LOD) SAG values differ from LOAD2 reference by ~280–580 bits
   per image due to the look-ahead lead_n heuristic not being fully replicated. Main image
   SAGs, CTRL words, SIZX/SIZY, PAL, and PT pairs all match the reference exactly.
2. **Scale count**: Depends on PTTBL presence — images with pttblnum=-1 get
   scale count 1 instead of the default 2 (observed with YOK_HIT2.IMG test).
3. **CTRL+PWRD line formatting**: LOADW outputs CTRL and PWRD1/2/3/PT3Y on a single `.word` line
   (e.g. `06580H,-1,-1,-1,0`). LOAD2 outputs them on separate lines. Our implementation
   matches LOAD2 (separate lines), which is the correct target.

## Implementation Status

All critical features now match LOADW output exactly:

| Feature | Status | Notes |
|---------|--------|-------|
| SIZX | ✓ | `PTTBL[pttblnum - n_special].BOX[1].W` |
| SIZY | ✓ | `rec->h` |
| SAG format | ✓ | Raw bit offset, no base_addr added (e.g. `00H`, `0620cH`) |
| CTRL (Y4AH4A01) | ✓ | `06580H` |
| CTRL (Y4AH4A02) | ✓ | `06480H` |
| PAL | ✓ | Palette label name (e.g. `YOKRED_P`) |
| PWRD | ✓ | `-1,-1,-1,0` format |
| PT pairs (all 8 values) | ✓ | Verified against LOADW for Y4AH4A01/02/03 |
| Scale format | ✓ | SAG:L + CTRL:W only |
| Scale CTRL | ✓ | CMP bit set (`06080H`) |
| .TEXT trailer | ✓ | `\t.TEXT\r\n` + `0x1a` EOF marker |
| Palette (.globl) | ✓ | Writes `.globl\tPALNAME` to GLO |
| IRW header | ✓ | Date, n_images, bpp, total_size |
| Compression | ~95% | Running-minimum lead_n w/ look-ahead; SAG offsets differ slightly |

### Running-Minimum Lead_N

The compression algorithm uses a running-minimum for lead_n across rows
with a 4-row look-ahead for initial rows. This ensures the LM/TM multipliers
match LOADW. When SIZX ≤ 15, LM=0/TM=0 are forced regardless of actual
zero counts (matching LOADW behavior).
