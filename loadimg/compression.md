# loadimg — Compression Algorithm Reference

This document captures the reverse-engineering results from LOADW.EXE (MS-DOS, 5/25/94)
for the DMA2 zero-run compression algorithm used in **Mortal Kombat 2** data.

---

## IRW Format

### Header (0x44 bytes)

| Offset | Size | Field |
|--------|------|-------|
| 0x00 | 8 | ASCII date string (e.g. `"03/14/95"`) |
| 0x20 | 2 | Image count (LE uint16) |
| 0x22 | 1 | Global bpp (max across all images) |
| 0x2e | 1 | Flags (0x02) |
| 0x30 | 4 | Total file size (LE uint32) |

Data section starts at offset 0x44. Images are sequentially bit-packed with no
delimiters. SAG values in the TBL are bit offsets relative to the start of the
data section (+ base address + bank offset).

## DMA2 CTRL Word (from `DMA2.DOC` — Keep Enterprises, Jan 1992, Rev 1.5)

```
Register #1 — CONTROL REGISTER:
|DGO| PIX SIZE |TM1|TM0|LM1|LM0|CMP|CLP|VFL|HFL| PIXEL OPS |

Bit  [15]     DGO — DMA Go (always 0 in TBL)
Bits [14-12]  PIX — pixel size (0=8bpp, 1-7=bpp)
Bits [11-10]  TM  — trailing-zero multiplier selector (0=x1, 1=x2, 2=x4, 3=x8)
Bits [9-8]    LM  — leading-zero multiplier selector  (0=x1, 1=x2, 2=x4, 3=x8)
Bit  [7]      CMP — compression enable (1=ZON, 0=ZOF)
Bit  [6]      CLP — clip enable
Bits [5-0]    Misc flags (VFL, HFL, OPS)

NOTE 2 from DMA2.DOC: In compression mode, scaling and clipping are inhibited.
```

## Row Compression Format (ZON mode) — from DMA2.DOC

Each compressed row = 1 header byte + stored pixels (bit-packed LSB-first).
The DMA2 hardware decodes this on-the-fly during transfer.

```
Header byte:  [trail_n : 4 bits][lead_n : 4 bits]

lead_c = lead_n × lm_mult    — leading zero pixels skipped by hardware
trail_c = trail_n × tm_mult  — trailing zero pixels skipped
stored = sizx − lead_c − trail_c — pixels actually in the bitstream

Row total bits = 8 + stored × bpp
Pixels are LSB-first bit-packed.
```

Examples from DMA2.DOC:
- Header 0x62 with LM=0, TM=0: lead_n=2, trail_n=6 → 2 leading, 6 trailing zeros skipped
- Header 0x62 with LM=1, TM=1: lead_n=2×2=4, trail_n=6×2=12 → 4+12=16 zeros skipped

The multiplier selectors map as: 0→×1, 1→×2, 2→×4, 3→×8.
lead_n and trail_n are each 4-bit values (0-15).

## LOADW Algorithm (From Ghidra Decompilation)

### Key Functions

| Function     | Address      | File offset | Source | Purpose |
|-------------|--------------|-------------|--------|---------|
| `_packbits`  | 0x1000:5b64 | 0x7564     | `load2.c` | Main compression |
| `_do_zcom`   | 0x100a:fa02 | 0x11402    | `zcom.c` | Zero-compression row writer |
| `FUN_1000_6f20` | 0x1000:6f20 | 0x8920 | — | LM/TM optimizer + row encoding |
| `FUN_1854_37dd` | 0x1854:37dd | —       | — | Row checksum (dedup) |
| `_load_bits` | 0x1000:737c | 0x8d7c    | `load2.c` | Bit I/O |
| `_compute_bpp` | 0x1000:35a1 | 0x4fa1  | `load2.c` | BPP calculation |

### LM/TM Selection (FUN_1000_6f20)

Full decompile at `/tmp/decomp_checksum_lead.txt`. Matched by `analyze_image()`.
Parameters:
- `param_1/param_2`: pixel buffer pointer (far pointer)
- `param_3`: row count (rec->h)
- `param_4`: SIZX (not rec->w)
- `param_5`: bpp

#### First Pass — Per-Row Lead/Trail Counting

```
For each row y in 0..h-1:
  Count lead (capped at 120, bVar8 logic) across sizx pixels
  Count trail (only after lead finishes) across sizx pixels

  For each multiplier m in 0..3:
    mult = 1 << m
    lead_n = min(lead / mult, 15)
    lead_err[m] += lead - mult * lead_n
    trail_n = min(trail / mult, 15)
    trail_err[m] += trail - mult * trail_n

Select LM = m where lead_err[m] is minimum (strict <, lower index on tie)
Select TM = m where trail_err[m] is minimum (<, lower index on tie)
```

Lead/trail counting:
- **Lead**: capped at 120 (0x78), stops at first non-zero pixel
- **Trail**: only counts after lead finishes, only when `sizx - 120 < x`
  (always true for sizx ≤ 120). Resets to 0 on non-zero pixel.

#### Pixel scan loop

```c
for (int x = 0; x < sizx; x++) {
    uint8_t px = (x < rec->w) ? row[x] : 0;
    if (!lead_done) {
        if (lead == 120) lead_done = 1;
        else if (px == 0) lead++;
        else lead_done = 1;
    } else if (sizx - 120 < x) {
        if (px == 0) trail++;
        else trail = 0;
    }
}
```

#### Second Pass — Minimum Stored = 10 Adjustment

After LM/TM selection, per-row header bytes adjust when `stored = sizx - lead_c - trail_c < 10`:

```c
if (stored < min_stored) {
    need = min_stored - stored;
    red_l = min(lead_c, need);
    lead_c -= red_l, need -= red_l;
    if (need > 0 && trail_c >= need) trail_c -= need;
    else if (need > 0 && trail_c > 0) trail_c = 0;
    // recompute lead_n, trail_n from adjusted lead_c, trail_c
}
```

This matches FUN_1000_6f20's post-processing at the end of its second pass.

#### Error accumulation and selection

```c
for (int m = 0; m < 4; m++) {
    int mult = 1 << m;
    int ln = min(lead / mult, 15);
    lead_err[m] += lead - mult * ln;
    int tn = min(trail / mult, 15);
    trail_err[m] += trail - mult * tn;
}

int best_lm = 0;
for (int m = 1; m < 4; m++)
    if (lead_err[m] < lead_err[best_lm]) best_lm = m;

int best_tm = 0;
for (int m = 1; m < 4; m++)
    if (trail_err[m] < trail_err[best_tm]) best_tm = m;
```

#### Verification

The accumulated errors match LOADW's verbose output exactly. For TMSTANCE1A:
- `lead_err`: 143 (×1), 78 (×2), 260 (×4), 532 (×8)
- `trail_err`: 69 (×1), 110 (×2), 340 (×4), 452 (×8)
- Selected: LM=1 (×2), TM=0 (×1)

### CMP=0 — Space Check

After LM/TM selection and the minimum-stored=10 adjustment, FUN_1000_6f20
performs a **space check**: if the compressed bitstream would be larger than
or equal to the raw pixel data, compression is disabled (CMP=0).

```
comp_bits = sum over all rows of (8 + stored × bpp)
raw_bits = sizx × h × bpp
do_cmp = (sizx >= 10 && comp_bits <= raw_bits)
```

Two conditions must both hold:
1. **sizx >= 10**: "Need 10 non-zero pixels minimum" — images narrower than
   10 pixels are never compressed (CMP=0). This matches LOADW's logic:
   if `sizx < 10`, the `min_stored = 10` adjustment consumes the entire row,
   leaving zero stored pixels.
2. **comp_bits <= raw_bits**: compressed size must be strictly less than or
   equal to raw size (`<=` comparison). If equal, CMP=0 — not worth encoding.

### Stride Handling

FUN_1000_6f20 walks the pixel buffer using SIZX-stride, not rec->w-stride.
`analyze_image` reads the first `sizx` pixels per row from the IMG buffer
(stride = `(rec->w+3)&~3`). The `_do_sclpad` buffer in `encode_image` creates
a proper SIZX-stride buffer for per-row encoding (zero-copied from IMG buffer).

### Row Encoding (encode_row)

```
lead_n = lead / lm_mult           (clamped to 15)
lead_c = lead_n × lm_mult         (clamped to sizx)
trail_n = trail / tm_mult         (clamped to 15)
trail_c = trail_n × tm_mult       (clipped if lead_c+trail_c > sizx)
stored = sizx - lead_c - trail_c  (clamped to 0)
```

Header byte: `(trail_n << 4) | lead_n`. Then `stored` pixels LSB-first at `bpp` bits each.

### Lead Counting

Per-row lead, counted from left of SIZX (not rec->w), with 120 cap.
No running minimum — each row's lead is independent, matching LOADW's
FUN_1000_6f20 (not the dispatch loop's running minimum).

LOadw's `_packbits` dispatch loop uses a running minimum, but the actual
compression in FUN_1000_6f20 uses per-row lead. Our implementation matches
FUN_1000_6f20 (the authoritative compression function).

### Trail Counting

Trail is counted from the right edge of SIZX, per-row (not a running value),
zero-padded beyond rec->w.

## LOADW Compression Architecture

`_packbits` at 0x1000:5b64 is the image-level compression entry point.
It operates as a **packed command processor** — building a command queue
that is executed by a separate dispatcher loop.

### Key Ghidra Findings

1. **`FUN_1000_6f20` (LM/TM selection)**: Confirmed to match our
   `choose_mult_min_error` implementation. The function scans SIZX pixels
   per row with stride `(-sizx)&3`, counting lead with a 120 cap (bVar8
   logic) and trail only after lead completes. Selects LM/TM by minimizing
   error. Second pass applies minimum-stored=10 adjustment. Performs space
   check (CMP=0 if compressed >= raw).

2. **Checksum dedup (`FUN_1854_35fc`)**: Uses sum of pixel bytes (as uint32)
   and max over byte-pairs as the checksum. Looks up in table matching SIZX,
   SIZY, checksum sum, checksum max, and CTRL. Table resets on IMG change
   (new `.IMG` file loaded).

3. **CON>/COF> flag**: `byte [0x5b60]` gates the checksum dedup logic
   in `_packbits`. When non-zero, LOADW checksum-computes and deduplicates.
   Our `g.dedup` variable: 1 = dedup ON, 0 = dedup OFF. Default is ON.

4. **`_do_zcom`** at 0x100a:fa02: Memory allocation wrapper for the
   compression buffer. Not the per-row encoder itself.

5. **`FUN_1854_38f9`**: Row writer that queues encoding commands
   (SIZX, SIZY, checksum, CTRL) to a work buffer.

## Current Status — Byte-Exact Match

### ZON (Compressed) Mode

| Test | Images | Mode | Match |
|------|--------|------|-------|
| **MK2MIL** | 159 | ZON | **100.0%** (IRW + TBL) |
| **MK4MIL** | 1899 | ZON | **100.0%** (IRW + TBL) |
| **MK7MIL** | ~1900 | ZON images | **100.0%** TBL |
| **MKSMALL** | 4 | ZON | **100.0%** IRW |

### ZOF (Uncompressed) Mode

| Test | Images | Mode | Match |
|------|--------|------|-------|
| **MKSMALL** | 4 | ZOF | **100.0%** |
| **MK3MIL** | 159 | ZOF | **100.0%** binary |
| **MK2MIL** (CON/COF) | 159 | ZOF | **100.0%** binary |

Key ZOF fix: pixel width uses stride `(w+3)&~3`, not `rec->w` (controlled by `/P` flag).
Without `/P`, tight packing `w` is used — also 100% match.

### BBB (Background) Mode

| Dataset | Status |
|---------|--------|
| Image encoding (IRW) | **100.0%** — same FUN_1000_6f20 algorithm |
| Background tables | ~50% — object/module structure output is WIP |

## CON> Checksum Dedup

LOADW supports toggling checksum dedup mid-LOD. Our implementation:

1. **`loadw_checksum()`**: Computes sum of pixel bytes as uint32 + max over
   byte-pairs. This matches `FUN_1854_35fc`.
2. **`dedup_table[]`**: Up to 4096 entries, keyed by `{sum, max_val, sizx, sizy, ctrl}`.
3. **Lookup**: Before encoding, if `g.dedup` is ON, compute checksum and scan table.
   If match found, reuse stored SAG — no IRW data written.
4. **State toggling**: `CON>` sets `g.dedup = 1`, `COF>` sets `g.dedup = 0`.
   Default is ON (`g.dedup = 1`). Table persists across state changes.
5. **Table reset**: When a new `.IMG` file is loaded, the dedup table is cleared
   (matching LOADW behavior).

## FRM> Directive

The `FRM>` directive loads a `.BIN` file (compressed movie footage) and writes
its raw bytes directly into the IRW bitstream. No compression is applied to
the .BIN data. A `.set` TBL entry is generated with `base_addr + irw_bit`
offset, and a `.globl` symbol is emitted to `IMGTBL.GLO`.

## BBB> Directive

The `BBB>` directive processes background files (`.BDB` + `.BDD`). Background
images use the same compression algorithm as regular sprites (FUN_1000_6f20).
See `bbb.md` for full documentation.

## Old-Format IMG (Pre-WimpV5)

Files with `temp != 0xabcd` use **42-byte IMG_REC** records (old LOAD2 format):

| Field | Old offset | New offset | Size |
|-------|-----------|-----------|------|
| name_s | 0 | 0 | 16 |
| xoff (ANIX) | 16 | 18 | 2 |
| yoff (ANIY) | 18 | 20 | 2 |
| xsize (W) | 20 | 22 | 2 |
| ysize (H) | 22 | 24 | 2 |
| palind (PALNUM) | 24 | 26 | 2 |
| flags (FLAGS) | 26 | 16 | 2 |
| oset (OSET) | 28 | 28 | 4 |
| data (DATA_P) | 32 | 32 | 4 |
| lib (LIB) | 36 | 36 | 2 |
| pword1 (ANIX2) | 38 | 38 | 2 |
| pword2 (ANIY2) | 40 | 40 | 2 |

Total: 42 bytes (old) vs 50 bytes (new). The `flags` field moved from offset 26 to offset 16.
No PTTBL entries exist (`pttblnum = -1`). New fields `ANIZ2`, `FRM`, `PTTBLNUM`, `OPALS` are set to 0/‑1.

Conversion: `img_load()` allocates `norm_images` (50-byte `IMG_REC[]`), copies fields from 42-byte
source with correct field mapping. Patches `img->hdr.temp = 0xabcd` so rest of pipeline works.

## Ghidra Artifacts

Decompiled function outputs are at:
- `/tmp/decomp_packbits.txt` — main compression (849 lines, 39668 chars)
- `/tmp/decomp_checksum_lead.txt` — LM/TM optimizer (4631 chars)
- `/tmp/decomp_row_encode.txt` — row checksum (1258 chars)
- `/tmp/decomp_calc_dim1.txt` — dimension calculation (1120 chars)
- `/tmp/decomp_calc_dim2.txt` — dimension calculation (466 chars)
- `/tmp/decomp_bpp.txt` — bpp computation
- `/tmp/decomp_creatept.txt` — point table creation

## Debug Symbols (COFF)

Extracted via `strings` from `LOADW.EXE` at `loadimg/binary/`:

| Symbol | Offset | Address | Description |
|--------|--------|---------|-------------|
| `_packbits` | 0x7564 | 1000:5b64 | Compression entry |
| `_do_zcom` | 0x11402 | 100a:fa02 | Zero-compression writer |
| `_load_bits` | 0x8d7c | 1000:737c | Bit I/O |
| `_compute_bpp` | 0x4fa1 | 1000:35a1 | BPP calc |
| `_create_point_table` | 0x8fe1 | 1000:75e1 | PT pair output |
| `_write_palette` | — | — | Palette output |
| `_write_row` | — | — | Row writing |
| `_write_tbl` | — | — | TBL writing |
| `_do_superbpp` | 0x52c0 | 1000:38c0 | "Super bpp" |
| `_bits_filled` | 0x117ce | 100a:fdce | Bit counter |
| `_color_average` | — | — | Color averaging |
