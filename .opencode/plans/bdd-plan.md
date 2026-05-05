# BBB> Directive Implementation Plan

## Overview

The `BBB>` directive loads BLIMP background files composed of paired `.BDB`
(object placement) and `.BDD` (image/palette container) files. These define
scrolling background layers used in Mortal Kombat 4 and MK7 arcade stages.

An initial implementation exists in `src/loadimg.c` (~450 lines, starting
at `process_lod()` line 1556) but has several bugs and gaps against the
LOADW reference output (`work3/BGNDTBL.ASM`, `work3/BGNDTBL.GLO`).

This plan describes what needs to be fixed or completed.

---

## Current Issues

### 1. Indentation / Structural Bug in LM/TM Analysis

**Location**: `src/loadimg.c` lines 1806–1821

**Problem**: The LM/TM analysis loop for background images has misaligned
braces. The `fprintf(g.bgnd_fp, "\r\n")` at line 1820 and the closing `}`
at line 1821 are inside the `for (int row = 0; row < h; row++)` loop.
The LM selection loop at lines 1822–1825 then falls outside the enclosing
`if (w > 0 && h > 0)` block due to the brace mismatch.

**Fix**: Correct the brace placement so the LM/TM selection (lines 1822–1825)
and CMP decision (lines 1827–1863) execute per-image, not after a broken loop.

### 2. Module Region Bounds (Object-to-Module Assignment)

**Location**: `src/loadimg.c` lines 1670–1678 (module param storage),
1743–1754 (range array population), 1762–1765 (assignment check)

**Reference**: BDB module line format: `NAME DEPTH_BASE SCROLL_X SY_BASE SY_SPAN`

**How assignment works** (verified against all 205 NUPOOL objects):
- Each module defines a rectangle: X=[DEPTH_BASE, SCROLL_X], Y=[SY_BASE, SY_BASE+SY_SPAN]
- SCROLL_X is the right-edge X coordinate
- Objects are assigned to the **first module in file order** whose rectangle
  contains the object's (DEPTH, SY) — this is a first-fit spatial partition,
  not a Y-sorted or best-fit match
- Module file order IS the BMOD/BLKS output order

**Current code bug**: `mod_ye` stores `sy_span` directly at line 1754
instead of computing `sy_base + sy_span`:
```c
mod_ye[n_bmod] = gobjs[gi].ii;                    // BUG: stores sy_span
```
Should be:
```c
mod_ye[n_bmod] = gobjs[gi].sy + gobjs[gi].ii;    // sy_base + sy_span
```

This is the only fix needed for correct object-to-module assignment. The
existing first-fit check at lines 1762–1765 is correct once bounds are right.

### 3. BLKS `wx` Low-Byte Derivation

**Location**: `src/loadimg.c` lines 1936, 1941

**Reference**: `bbb.md` lines 114–118, `BDD.md` lines 138–154

**Problem**: The current code writes the raw BDB `WX_hex` value directly
(e.g., `0x4000`). The LOADW reference BLKS output has computed low bytes
(e.g., `0x4044`, `0x4046`).

The low byte of `wx` in BLKS output encodes DMA/compression flags:
- bit 7: CMP (1 = compressed)
- bits 9-8: LM (leading multiplier index 0–3)
- bits 11-10: TM (trailing multiplier index 0–3)
- bits 6-0: OPS, CLP, VFL, HFL, PIX (from per-image state)

The raw BDB WX_hex has only the high byte (scroll rate) set; all other
fields are 0. LOADW ORs in the per-image compression flags.

**Action**: After computing `img_lm[di]`, `img_tm[di]`, and `img_cmp[di]`
(already done at lines 1863–1864), construct the BLKS wx value as:

```c
int wx_blks = gobjs[gi].wx | (img_cmp[di] << 7) | (img_lm[di] << 8) | (img_tm[di] << 10);
```

Note: `gi` here is the GOBJ index, not the BDD index. The BDD image
index (`ii`) must be mapped to the correct `img_lm[]` / `img_tm[]` /
`img_cmp[]` entry, which is keyed by BDD `di` (not GOBJ index).

### 4. BMOD Width/Height Formula

**Location**: `src/loadimg.c` lines 1958–1983

**Reference**: `bbb.md` lines 253–254

**Problem**: Width/height computed from object bounding boxes:
```c
mw = max_de - min_d;  // rightmost edge - leftmost edge
mh = max_se - min_sy;
```
The reference shows DPUL6BMOD width=802, but the param formula
`mod_de[mi] - mod_ds[mi]` gives 850. The bounding box approach
also doesn't match.

**Action**: Compare the computed values against the reference output
for all 6 NUPOOL modules. Adjust the formula if needed — LOADW may
use a different method (e.g., based on scroll register values or
param ranges, not actual object extents).

### 5. HDRS Entry Comments

**Location**: `src/loadimg.c` lines 1916–1921

**Status**: Already has a `first_bgnd` flag that emits `;x size, y size`,
`;address`, and `;dma ctrl` on the first entry only. This matches the
reference format described in `bbb.md` lines 156–161.

**Verification**: Compare against `work3/BGNDTBL.ASM` to confirm the
comments match exactly (spacing, capitalization).

### 6. BGNDTBL.GLO — ENDMARKER uses `.global` not `.globl`

**Location**: `src/loadimg.c` line 1046 (`write_global` function)

**Reference**: `work3/BGNDTBL.GLO` shows `.global ENDMARKER` while all
other entries use `.globl`.

**Problem**: The GLO> directive (e.g. `GLO> BGNDTBL.GLO` in MK7MIL.LOD)
directs global symbol output to a specific file. When `---> ENDMARKER`
is processed, `write_global("ENDMARKER")` writes `.globl ENDMARKER` but
the reference expects `.global ENDMARKER`.

**Fix**: In `write_global()`, special-case the name "ENDMARKER" to emit
`.global` instead of `.globl`:
```c
fprintf(g.glo_fp, "\t.%s\t%s\r\n",
        strcmp(name, "ENDMARKER") == 0 ? "global" : "globl", name);
```

**Order verification**: Current code writes PALS → palette names → BMOD
(lines 1993–1998), which matches the reference.

### 7. BGNDPAL.ASM Palette Dedup

**Location**: `src/loadimg.c` lines 2001–2017

**Problem**: The dedup check at line 2004 references `g.palettes[pi2].written`
to skip palettes already written to IMGPAL.ASM. However, the palette-writing
code for sprite images (in `parse_imglist`) may not set the `written` flag
on `PaletteEntry`.

**Action**: Ensure the `written` field is set to 1 after writing a palette
to IMGPAL.ASM (in the `write_palette()` function or the palette-handling
block at lines 1282–1314). Without this, background palettes that share
names with sprite palettes may be duplicated.

### 8. Background Image Encoding — Stride Padding

**Location**: `src/loadimg.c` lines 1784, 1867–1907

**Problem**: `sizx_a` is set to `w` (raw width, no stride padding).
The encode paths for both compressed and raw modes iterate `x < sizx_a`,
writing zero for `x >= w`. With `sizx_a = w`, there is no padding at all.

Sprite images use `pstride = (rec->w + 3) & ~3` (4-byte aligned stride).
If LOADW uses padding for background images, the IRW data and SAG offsets
will differ.

**Action**: Check the reference IRW and verbose log to determine whether
LOADW pads background image strides to 4 bytes. If so, change to
`sizx_a = (w + 3) & ~3`.

### 9. File Pointer Leaks

**Location**: `src/loadimg.c` main function line 2201–2207

**Problem**: The `g.asm_fp`, `g.glo_fp`, `g.pal_fp` are closed at the
end of main(). But `g.bgnd_fp`, `g.bgndpal_fp`, `g.bgndequ_fp`,
`g.bgndtbl_glo_fp` are NEVER closed. This may cause missing data or
corrupted output files.

**Action**: Close all background-output file pointers in `main()` after
`process_lod()` returns:

```c
if (g.bgnd_fp) fclose(g.bgnd_fp);
if (g.bgndpal_fp) fclose(g.bgndpal_fp);
if (g.bgndequ_fp) fclose(g.bgndequ_fp);
if (g.bgndtbl_glo_fp) fclose(g.bgndtbl_glo_fp);
```

---

## Verification

After all fixes, test against MK7MIL (`work3/`):

```bash
cd /home/alex/Projects/midway-imgtool/loadimg
./build/loadimg work3/MK7MIL.LOD /P /T
diff work3/BGNDTBL.ASM BGNDTBL.ASM
diff work3/BGNDTBL.GLO BGNDTBL.GLO
diff work3/BGNDPAL.ASM BGNDPAL.ASM
diff work3/BGNDEQU.H BGNDEQU.H
```

Compare against LOADW reference outputs in `work3/`. The 28 background
files (28 .BDB/.BDD pairs) should all produce matching output.

---

## Priority Order

| # | Item | Why this order |
|---|------|----------------|
| 1 | **File pointer leaks** (item 9) | Prevents corrupted output, trivial fix |
| 2 | **`mod_ye` fix** (item 2) | One-line change that cascades correct counts into everything downstream |
| 3 | **BGNDTBL.GLO `.global`** (item 6) | One-line `write_global` special-case |
| 4 | **BGNDPAL `written` flag** (item 7) | One-line fix, prevents palette duplication |
| 5 | **BLKS `wx` low byte** (item 3) | OR in CMP/LM/TM flags when writing BLKS entries |
| 6 | **BMOD width/height** (item 4) | Verify after fix #2 cascades correct object counts |
| 7 | **Indentation cleanup** (item 1) | Cosmetic — code works despite brace mess |
| 8 | **Stride padding** (item 8) | Verify against reference IRW |

---

## References

- `bbb.md` — Background file loading specification (this repo)
- `BDD.md` — BDD/BDB file format reference (this repo)
- `src/loadimg.c` — Implementation (lines 1556–2021)
- `work3/BGNDTBL.ASM` — Reference LOADW output for MK7MIL
- `work3/LOG_V5.TXT` — LOADW verbose log with object/module details
