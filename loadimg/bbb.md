# BBB Directive — Background File Loading

The `BBB>` directive loads BLIMP background files composed of paired `.BDB`
(object placement) and `.BDD` (image/palette container) files. These define
the scrolling background layers used in Mortal Kombat 4 / MK7 arcade stages.

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

**Status: NOT YET DETERMINED** — the exact rule LOADW uses to assign each
of the 205 objects to one of the 6 modules is still unknown.

**Key facts established from reference output (work3/BGNDTBL.ASM)**:
- Total objects across all modules = NUM_OBJECTS (205 for NUPOOL). No objects
  are left unassigned — every object appears in exactly one BLKS section.
- BLKS block counts: DPUL6=12, DPUL1=14, DPUL2=46, DPUL3=19, DPUL4=20, DPUL5=94

**wx high-byte distribution in BDB** vs **reference BLKS assignments**:

| Module  | BLKS count | wx_high bytes in ref BLKS  |
|---------|-----------|---------------------------|
| DPUL6   | 12        | 0x40 only                 |
| DPUL1   | 14        | 0x47 only                 |
| DPUL2   | 46        | 0x45, 0x46                |
| DPUL3   | 19        | 0x44 only                 |
| DPUL4   | 20        | 0x43 only                 |
| DPUL5   | 94        | 0x3f, 0x40, 0x41, 0x42, 0x43 |

wx_high distribution in BDB: 0x3f=4, 0x40=72, 0x41=13, 0x42=15, 0x43=22,
0x44=19, 0x45=32, 0x46=14, 0x47=14.

DPUL1 (wx_high=0x47, 14 objects) and DPUL3 (wx_high=0x44, 19 objects) match
exactly. DPUL2 (0x45+0x46 = 32+14 = 46) matches exactly. DPUL3/DPUL4 match.
But DPUL6 (12) is a subset of 0x40 (72), and DPUL5 (94) contains multiple
layers including most of 0x40. Assignment is NOT purely by wx_high byte.

**Hypothesis**: Assignment may use a combination of wx_high byte AND module
param ranges (SY_BASE/SY_SPAN or DEPTH_BASE/SCROLL_X) to disambiguate when
multiple modules share the same parallax layer.

**The `wx` value in BLKS output** differs from the BDB `WX_hex` field — the
BDB stores coarse values like `0x4000`, while the BLKS output has `0x4044`,
`0x4046`, etc. with computed low-byte flags. The low byte in BLKS is derived
from compression parameters (CMP/LM/TM bits) or other per-image data.
This relationship is not yet understood.

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

The `wx` value written to BLKS is NOT the raw BDB `WX_hex` — it appears to
have computed low-byte flags. Exact derivation unknown.

### BMOD Section

All BMOD entries for a BDB file are written after all BLKS sections:

```
DPUL6BMOD:
    .word   width,height,block_count    ;x size, y size, #blocks
    .long   DPUL6BLKS, OLHDRS, OLPALS
```

- `width`, `height` — derived from module params (exact formula TBD)
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
| BGNDPAL.ASM palette data | ✓ palette names and colors match |
| BGNDEQU.H equates format | ✓ per-module W/H from module params |
| Linux path flag parsing | ✓ fixed `/home/...` treated as `/H` flag |
| HDRS image data (all BDD images) | ✓ written in BDD file order |
| HDRS comments | ✗ first entry needs `;x size, y size` etc. |
| BLKS labels in correct position | ✗ currently emitted before HDRS data |
| BLKS object list format | ✗ not yet implemented |
| BLKS `wx` low-byte derivation | ✗ unknown (differs from BDB WX_hex) |
| Object-to-module assignment | ✗ unknown algorithm |
| BMOD width/height formula | ✗ unknown (not simply p2-p1, p4-p3) |
| BMOD block count | ✗ depends on assignment |
| Image compression in IRW | ✓ FUN_1000_6f20 with LM/TM selection |
| HDRS label derivation | ✓ last 2 chars of BDB name |
| Module hex detection | ✓ strtol-based, handles DPUL6 etc. |

## Open Questions

1. **BLKS `wx` low byte** — BDB has `0x4000` but BLKS output has `0x4044`.
   Where does the low byte come from? Candidates: per-image compression flags,
   DMA register bits computed from image properties.

2. **Object-to-module assignment** — wx_high alone doesn't determine the module
   (DPUL6 and DPUL5 both have 0x40 objects). Need to reverse-engineer LOADW's
   assignment loop.

3. **BMOD width/height** — reference shows DPUL6BMOD width=802 but param
   formula p2-p1=850. Likely computed from actual object extents.

## References

- `bddview.c` — Reference BDB/BDD viewer: https://github.com/Asure/midway-bddtool
- `bdd.md` — BDD/BDB format reference in this project
- `load2.hlp` — Original LOAD2 documentation (BBB> section)
- `src/loadimg.c` — BBB> handler at `process_lod()` (~400 lines)
- `work3/BGNDTBL.ASM` — Reference output from LOADW (MK7MIL.LOD, NUPOOL first)
- `work3/LOG_V5.TXT` — LOADW verbose log for MK7MIL.LOD run
