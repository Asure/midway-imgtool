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

## Issues Resolved

All 9 originally identified issues plus 2 additional fixes were implemented in this session. See commit history for details.

### 1. Indentation / Structural Bug in LM/TM Analysis

**Fixed**: Removed rogue `fprintf(g.bgnd_fp, "\r\n")` and fixed brace placement in the background LM/TM analysis loop.

### 2. Module Region Bounds (Object-to-Module Assignment)

**Fixed**: `mod_ye = sy_base + sy_span` (was `sy_span` directly). Assignment rule confirmed: first-fit by BDB file order using rectangle X=[DEPTH_BASE, SCROLL_X], Y=[SY_BASE, SY_BASE+SY_SPAN].

### 3. BLKS `wx` Low-Byte Derivation

**Fixed**: `wx_blks = (BDB_wx & 0xFFF0) | 0x0040 | (fl & 0x0F)` — CLP bit 6 set, OPS field from BDB palette index, bit 0 from BDD dma_bit0.

### 4. BMOD Width/Height Formula

**Fixed**: Bounding box from actual object extents including image dimensions (`max - min`).

### 5. HDRS Entry Comments

Already had `first_bgnd` flag — verified correct.

### 6. BGNDTBL.GLO — ENDMARKER uses `.global` not `.globl`

**Fixed**: `write_global()` special-cases ENDMARKER to emit `.global`.

### 7. BGNDPAL.ASM Palette Dedup

Already correct — `write_palette()` sets `pe->written = 1`.

### 8. Background Image Encoding — Stride Padding

**Fixed**: `sizx_a = ((w + 3) & ~3)` — 4-byte aligned stride.

### 9. File Pointer Leaks

**Fixed**: `fclose()` calls for `bgnd_fp`, `bgndpal_fp`, `bgndequ_fp`, `bgndtbl_glo_fp`.

### 10. Unique Color BPP Increase

**Fixed**: When an image has more unique colors than current bpp can represent (>64 for bpp=6), increase bpp to 7 or 8. Matches LOADW's "BG block has N colors. Can't fit into 6 bits per pixel." behavior.

### 11. Background Image Dedup

**Fixed**: Checksum-based dedup using shared `dedup_table`. Reuses SAG from previous identical images, matching LOADW's "block cksum match" messages.

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

## Priority Order (all completed)

| # | Item | Status |
|---|------|--------|
| 1 | **File pointer leaks** | **Done** — 4 `fclose()` calls in `main()` |
| 2 | **`mod_ye` fix** | **Done** — `sy_base + sy_span` instead of raw `sy_span` |
| 3 | **BGNDTBL.GLO `.global`** | **Done** — `write_global()` special-case for ENDMARKER |
| 4 | **BGNDPAL `written` flag** | **Done** — already correct in code |
| 5 | **BLKS `wx` low byte** | **Done** — CLP=1, OPS from `fl`, dma_bit0 from BDD |
| 6 | **BMOD width/height** | **Done** — bounding box from object extents, matches ref |
| 7 | **Indentation cleanup** | **Done** — removed rogue fprintf, fixed braces |
| 8 | **Stride padding** | **Done** — `sizx_a = ((w+3)&~3)` |
| 9 | **Dedup + unique colors + small-image CMP** | **Done** — all three implemented |
| 10 | **BLKS coordinate system** | **Done** — `x = depth - first_depth`, `y = sy - sy_base - 2` |
| 11 | **First-fit assignment in BLKS/BMOD** | **Done** — range check replaced with full first-fit |

---
## References

- `bbb.md` — Background file loading specification (this repo)
- `BDD.md` — BDD/BDB file format reference (this repo)
- `src/loadimg.c` — Implementation (lines 1556–2021)
- `work3/BGNDTBL.ASM` — Reference LOADW output for MK7MIL
- `work3/LOG_V5.TXT` — LOADW verbose log with object/module details

---
## Current Status (MKBBB — 3 backgrounds)

| File | Status |
|------|--------|
| BGNDTBL.GLO | **MATCH** ✓ |
| BGNDEQU.H | **MATCH** ✓ |
| BGNDTBL.ASM | **MATCH** ✓ (full byte-identical with reference) |
| IRW (NUPOOL) | **100% byte-identical** ✓ |
| IRW (TOMB/TOWER2) | 26% diff — LM/TM selection for CMP=1 images |
| BGNDPAL.ASM | Content matches, formatting differs (line breaks, hex width) |

## Remaining Work

| Issue | Status | Notes |
|-------|--------|-------|
| LM/TM for CMP=1 | Mismatch | Same FUN_1000_6f20 issue as MK3MIL/MK5MIL cascade |
| BGNDPAL formatting | Cosmetic | Palette numbering, line wrapping, hex width |
| All 9 plan items | **Done** | Implemented across this session |
