# BBB Directive — Background File Loading

The `BBB>` directive loads BLIMP background files composed of paired `.BDB`
(object placement) and `.BDD` (image/palette container) files. These define
the scrolling background layers in Mortal Kombat 2 arcade stages.

## File Formats

### BDB — Object Placement List (ASCII)

The `.BDB` file is an ASCII text file. It uses the structured format:

```
NAME WORLD_W WORLD_H MAX_DEPTH NUM_MODULES NUM_PALS NUM_OBJECTS\r\n
MODULE_NAME DEPTH_BASE SCROLL_X SY_BASE SY_SPAN\r\n   ← repeated NUM_MODULES times
WX_hex DEPTH SY II_hex FL\r\n                          ← repeated NUM_OBJECTS times
```

**Header line** (7 fields):
- `NAME` — world identifier (used for BGNDEQU.H equates and label suffix)
- `WORLD_W`, `WORLD_H` — world dimensions in pixels
- `MAX_DEPTH` — maximum depth value
- `NUM_MODULES` — number of module lines that follow
- `NUM_PALS` — number of palettes in the matching BDD
- `NUM_OBJECTS` — number of object lines that follow

**Module lines** (exactly `NUM_MODULES` lines, read sequentially after header):
- `MODULE_NAME` — base name for BLKS/BMOD labels
- `DEPTH_BASE`, `SCROLL_X`, `SY_BASE`, `SY_SPAN` — spatial parameters
  (exact meaning for object assignment not yet confirmed)

**Object lines** (exactly `NUM_OBJECTS` lines, read after module lines):
- `WX_hex` — parallax/DMA flags (high byte = scroll rate, low byte = flip/clip/ops)
- `DEPTH` — horizontal world position
- `SY` — screen Y position
- `II_hex` — image index into the paired .BDD file (BDD `idx` field, hex)
- `FL` — palette index (selects BDD palette in file order, 0-based)

**Parsing**: Use `NUM_MODULES` and `NUM_OBJECTS` from the header to read exactly
the right number of each line type sequentially — do NOT infer from line content.

**Important**: The hex check on `WX_hex` must verify the ENTIRE string using
`strtol` (not just `%lx`) because module names like `DPUL6` start with valid
hex digits. The structured count-based parser makes this moot.

### BDD — Image Container (Binary + ASCII)

The `.BDD` file is a mixed binary/text format containing indexed-color
images and RGB555 palettes.

```
<count>\n
<idx_hex> <w> <h> <flags>\n
<w × h bytes of raw 8-bit pixel data>
... repeat for each image ...
<PAL_NAME> <count>\n
<count × 2 bytes of RGB555 colour data>
... repeat for each palette ...
```

**Critical**: Pixel data is binary and may contain `0x0a` or `0x0d` bytes.
Parsing MUST use **byte-level offset tracking** (not `strchr`/`strtok`/`fgets`).

**Palette names** are ASCII tokens followed by a space and decimal count.

## Module and Object Structure

BDB files list ALL module declarations first, then ALL object definitions.
The header gives exact counts for both:

```
NUPOOL 4000 3000 255 6 7 205       ← header (6 modules, 205 objects)
DPUL6 325 1175 17 206               ← module 1
DPUL1 108 2482 1634 2100            ← module 2
...
4700 109 1714 0 0                    ← object 1
4000 152 286 3 2                     ← object 2
...
```

### Object-to-Module Assignment

**Status: RESOLVED**

Objects are assigned to modules using **first-fit by file order**. Each module
defines a rectangular region:
- X: [DEPTH_BASE, SCROLL_X]
- Y: [SY_BASE, SY_BASE + SY_SPAN]

An object belongs to the **first module** (in BDB file order) whose region
contains the object's (DEPTH, SY) coordinates. This is NOT a spatial partition
sorted by position — the BDB module order is the priority order.

**Verification**: This algorithm was verified against all 205 NUPOOL objects
and produces exact reference block counts for all 6 modules:
DPUL6=12, DPUL1=14, DPUL2=46, DPUL3=19, DPUL4=20, DPUL5=94.

**Key implementation detail**: When SCROLL_X IS the right-edge X coordinate
of the module rectangle. The `scroll_x` field name refers to the horizontal
scroll register position, which serves as the right boundary coordinate.

## Label Derivation

| Label | Format | Example |
|-------|--------|---------|
| HDRS  | Last 2 chars of BDB header name + `HDRS` | `NUPOOL` → `OLHDRS` |
| BLKS  | Module name + `BLKS` | `DPUL6` → `DPUL6BLKS` |
| BMOD  | Module name + `BMOD` | `DPUL6` → `DPUL6BMOD` |
| PALS  | Last 2 chars of BDB header name + `PALS` | `NUPOOL` → `OLPALS` |

## BGNDTBL.ASM Structure

The full output for one BDB file is written in this order:

```
OLHDRS:
    .word   w,h         ;x size, y size
    .long   addrH       ;address
    .word   ctrlH       ;dma ctrl
    ... one triplet per BDD image (ALL images, in BDD file order) ...

DPUL6BLKS:
    .word   wxH         ;flags          ← first object's wx
    .word   depth,sy    ;x,y            ← first object's position
    .word   hdrH        ;pal5,pal4,hdr13-0  ← first object's hdr index
    .word   wxH,depth,sy,hdrH           ← subsequent objects (4 per line)
    ...
    .word   0FFFFH      ;End Marker
DPUL1BLKS:
    ...

DPUL6BMOD:
    .word   width,height,block_count    ;x size, y size, #blocks
    .long   DPUL6BLKS, OLHDRS, OLPALS
...
```

### HDRS Section

- Contains ALL BDD images in file order (not filtered by which objects use them)
- Count = BDD image count (e.g., 43 for NUPOOL)
- First entry has `;x size, y size`, `;address`, `;dma ctrl` comments
- Subsequent entries have no comments

### BLKS Section

Each module gets one BLKS section. Format:
- **First object** splits across 3 `.word` lines (with comments)
- **Subsequent objects** are 4 values per `.word` line: `wx, depth, sy, hdr_index`
- **Terminator**: `.word 0FFFFH ;End Marker`
- `hdr_index` = 0-based position of the BDD image in the HDRS table (BDD file order)

The `wx` value written to BLKS is assembled from:
- **High byte (bits 15-8)**: from BDB `WX_hex` (parallax scroll rate)
- **CLP bit (bit 6)**: always set (clip enable for all background objects)
- **OPS field (bits 3-0)**: from BDB `fl` field (palette index)
- **Bits 5-4**: VFL/HFL from BDB `WX_hex`
- **Bit 0**: from BDD `dma_bit0` field

### BMOD Section

All BMOD entries for a BDB file are written after all BLKS sections:

```
DPUL6BMOD:
    .word   width,height,block_count    ;x size, y size, #blocks
    .long   DPUL6BLKS, OLHDRS, OLPALS
```

- `width`, `height` — computed from object bounding boxes (max_dim - min_dim
  across all objects assigned to the module, including image dimensions)
- `block_count` — number of objects assigned to this module
- `.long` references: own BLKS, shared HDRS, shared PALS label

### CTRL Word (in HDRS)

The DMA CTRL word for each background image encodes compression parameters:

- Bits 15-12: bpp (auto-detected from max pixel value)
- Bits 11-10: TM (trailing multiplier index, 0-3)
- Bits 9-8: LM (leading multiplier index, 0-3)
- Bit 7: CMP (1 = compressed, 0 = raw)

## Compression

Background images use the same FUN_1000_6f20 ZON compression algorithm
as regular sprites:

1. Determine bpp from max pixel value (`bpp_for_max(maxpx)`)
2. Try all 16 LM/TM combinations (×1, ×2, ×4, ×8 each)
3. For each combo: compute per-row lead/trail with 120 cap and bVar8
4. Apply minimum stored=10 adjustment to each row
5. Select LM/TM with smallest total compressed size
6. If compressed >= raw size, use CMP=0 (raw pixels)

## Implementation Details

- **File lookup**: Tries `IMGDIR` first, then current directory
- **BDB read**: Use count-based parsing from header fields
- **BDD read**: Loaded into malloc'd buffer; parsed with byte-level position
  tracking to handle binary pixel data containing 0x0a/0x0d bytes
- **Image dedup**: Each BDD image is written to IRW only once (deduplicated
  by BDD file position); all 43 images are written regardless of whether any
  object references them
- **HDRS**: ALL BDD images in file order, not just referenced ones
- **Palettes**: Written to BGNDPAL.ASM with names from the BDD file
- **Linux path fix**: Flag parser checks `isalpha(a[1])` and short arg length
  to avoid treating absolute paths like `/home/...` as `/H` flag

## Current Status

| Component | Match vs LOADW |
|-----------|---------------|
| Image TBLs (all 11 tables) | ✓ 100% |
| BGNDTBL.GLO | ✓ exact match |
| BGNDEQU.H | ✓ exact match |
| BGNDPAL.ASM palette data | ✓ palette names and colors match |
| BGNDTBL.ASM HDRS image data | ✓ all BDD images in file order |
| BGNDTBL.ASM HDRS addresses/CTRL | ✓ match (bpp=0 for 8-bit, CMP=1 forced) |
| BGNDTBL.ASM BLKS wx encoding | ✓ CLP+OPS+dma_bit0 correctly assembled |
| BGNDTBL.ASM BLKS coordinates | ✓ module-local, BDB file order |
| BGNDTBL.ASM BLKS object counts | ✓ first-fit by file order |
| BGNDTBL.ASM BMOD w/h | ✓ bounding box from objects |
| Image encoding in IRW | ✓ FUN_1000_6f20 with LM/TM selection |
| Background image dedup | ✓ checksum-based, shared dedup table |
| Object-to-module assignment | ✓ first-fit by file order |
| HDRS/PALS label derivation | ✓ DOS 8.3 suffix (chars 4-7) |
| BGNDTBL.GLO ENDMARKER | ✓ `.global` for ENDMARKER |
| File pointer cleanup | ✓ all bgnd_fp closed in main() |
| Linux path flag parsing | ✓ `/home/...` fixed |
| Module hex detection | ✓ strtol-based, handles DPUL6 etc. |
| BDD multi-newline handling | ✓ skips all consecutive newlines |
| Unique color bpp bump | ✓ increases bpp when >64 colors |
| Small image CMP=0 | ✓ width/height < 10 → no compression |

## Remaining Differences

| Issue | Status |
|-------|--------|
| LM/TM selection | LM differs for some CMP=1 images (same FUN_1000_6f20 mismatch as sprites) |
| BGNDPAL.ASM palette numbering | Off by 1 (PAL #0 vs #1) — cosmetic |
| BGNDPAL.ASM color format | Variable vs fixed-width hex — cosmetic |
| BGNDPAL.ASM line wrapping | LOADW wraps palette data at ~10 entries per line |

## References

- `bddview.c` — Reference BDB/BDD viewer: https://github.com/Asure/midway-bddtool
- `bdd.md` — BDD/BDB format reference in this project
- `load2.hlp` — Original LOAD2 documentation (BBB> section)
- `src/loadimg.c` — BBB> handler at `process_lod()` (~400 lines)
- `work3/BGNDTBL.ASM` — Reference output from LOADW (MK7MIL.LOD, NUPOOL first)
- `work3/LOG_V5.TXT` — LOADW verbose log for MK7MIL.LOD run
