# BBB Directive — Background File Loading

The `BBB>` directive loads BLIMP background files composed of paired `.BDB`
(object placement) and `.BDD` (image/palette container) files. These define
the scrolling background layers used in Mortal Kombat 4 / MK7 arcade stages.

## File Formats

### BDB — Object Placement List (ASCII)

The `.BDB` file is an ASCII text file with `\r\n` line endings. It defines
background objects (tiles), their screen placement, and image references.

```
NAME WORLD_W WORLD_H UNUSED1 UNUSED2 UNUSED3 UNUSED4\r
MODULE_NAME PARAM1 PARAM2 PARAM3 PARAM4\r
WX_hex DEPTH SY II_hex FL\r
WX_hex DEPTH SY II_hex FL\r
...
```

**Header line** (first line):
- `NAME` — world identifier (used for BGNDEQU.H equates)
- `WORLD_W`, `WORLD_H` — world dimensions in pixels

**Module lines** (first token is non-hex text):
- `MODULE_NAME` — creates a section label in BGNDTBL.ASM
- `PARAM1-4` — module parameters (scroll rate, depth, etc.)

**Object lines** (first token is valid hex):
- `WX_hex` — DMA control word (scroll rate + flip flags)
- `DEPTH` — depth/plane number
- `SY` — screen Y position
- `II_hex` — image index into the paired .BDD file (hex)
- `FL` — palette index

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
Common palette names: `STEEL_P`, `GRID_P`, `DPOOL_P`, `NESS_P`, `DUSK2_P`,
`DUSK3_P`, `DUSK1_P`.

## Line Identification

BDB lines are classified by their first token:

| Token type | Classification | Example |
|------------|---------------|---------|
| Valid hex number | Object entry | `4700 109 1714 0 0` |
| Non-hex text | Module header | `DPUL6 325 1175 17 206` |

Module headers create named label sections in BGNDTBL.ASM. All objects
following a module header belong to that module until the next module header.

## Output Files

| File | Description |
|------|-------------|
| `BGNDTBL.ASM` | Background object table (`.word w,h / .long SAG / .word ctrl` per object) |
| `BGNDPAL.ASM` | Background palettes (RGB555 colour tables with labels) |
| `BGNDEQU.H` | World dimension equates (`Wname`/`Hname`) |
| `BGNDTBL.GLO` | Global symbol declarations for BGNDTBL labels |

### BGNDTBL.ASM Format

```
.OPTION B,D,L,T
.include "BGNDTBL.GLO"
.DATA

MODULE_NAME:
    .word   <width>,<height>     ; image dimensions
    .long   <base_addr + SAG>    ; address of compressed data in IRW
    .word   <dma_ctrl>           ; CTRL = (bpp<<12)|(tm<<10)|(lm<<8)|CMP
    ... repeated for each object ...
```

### CTRL Word Construction

The DMA CTRL word for each background object encodes the compression
parameters selected by FUN_1000_6f20:

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

The same lead/trail counting and adjustment algorithm from `analyze_image()`
and `encode_row()` is used.

## Implementation Details

- **File lookup**: Tries `IMGDIR` first, then current directory
- **BDB read**: Loaded entirely into a 64KB buffer as ASCII text
- **BDD read**: Loaded into malloc'd buffer; parsed with byte-level position
  tracking to handle binary pixel data containing 0x0a/0x0d bytes
- **Image dedup**: Each BDD image is written to IRW only once; multiple BDB
  objects referencing the same BDD image index share the same SAG
- **Module labels**: Named from the BDB module line's first token
- **Palettes**: Written to BGNDPAL.ASM with names from the BDD file

## Current Status

| Component | Match vs LOADW |
|-----------|---------------|
| Image data in IRW | ~50% (compression LM/TM matching differs) |
| BGNDTBL.ASM labels | ✗ (uses module names directly, not LOADW's naming convention) |
| BGNDPAL.ASM | ✓ (palette data matches byte-exact) |
| BGNDEQU.H | ✓ (world dimension equates match) |
| BGNDTBL.GLO | ✓ (global symbols match) |

The palette data and world dimension equates match the reference exactly.
The BGNDTBL.ASM labels and image compression parameters differ from LOADW's
output due to differences in label derivation (module vs module+BLKS/BMOD)
and LM/TM selection edge cases.

## References

- `bddview.c` — Reference BDB/BDD viewer: https://github.com/Asure/midway-bddtool
- `bdd.md` — BDD/BDB format reference in this project
- `load2.hlp` — Original LOAD2 documentation (BBB> section)
- `src/loadimg.c` — BBB> handler at `process_lod()` (~400 lines)
