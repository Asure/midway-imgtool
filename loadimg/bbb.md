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

BDB lines are classified by their first token using two-stage sscanf:

| Token type | Detection | Example |
|------------|-----------|---------|
| Valid hex number (all chars) | `strtol` + `endp` check | `4700 109 1714 0 0` → object |
| Non-hex text | Object sscanf fails (not all 5 fields), OR module sscanf + `strtol` fails | `DPUL6 325 1175 17 206` → module |

**Important**: The hex check must verify the ENTIRE string using `strtol`. Using `%lx` alone would match `DPUL6` because `D` is a valid hex digit. The `strtol`-based check ensures every character is valid hex.

Object format: `WX_hex DEPTH SY II_hex FL` (5 fields, first is hex)
Module format: `NAME param1 param2 param3 param4` (text name + 4 decimal integers)

Object lines with fewer than 5 fields (e.g., module headers with wrong format) will NOT be parsed as objects.

## Module and Object Structure

BDB files list ALL module declarations first, then ALL object definitions:

```
NUPOOL 4000 3000 255 6 7 205       ← header
DPUL6 325 1175 17 206               ← module 1
DPUL1 108 2482 1634 2100            ← module 2
...
4700 109 1714 0 0                    ← object (belongs to module determined by DEPTH/SY)
4000 152 286 3 2                     ← object
...
```

Objects are NOT grouped by position after their module. LOADW assigns objects to
modules by matching the object's `DEPTH` and `SY` fields against each module's
parameter range. The exact matching algorithm (`param1-param4` vs `DEPTH`/`SY`)
still needs reverse engineering.

## Label Derivation

| Label | Format | Example |
|-------|--------|---------|
| HDRS | Last 2 chars of BDB header name + `HDRS` | `NUPOOL` → `OLHDRS` |
| BLKS | Module name + `BLKS` | `DPUL6` → `DPUL6BLKS` |
| BMOD | Module name + `BMOD` | `DPUL6` → `DPUL6BMOD` |
| PALS | Last 2 chars of BDB header name + `PALS` | `NUPOOL` → `OLPALS` |

From Ghidra analysis at `45e8` segment:
- `%.*sBLKS:` — formatted with precision (truncated module name)
- `%sBMOD:\n` — module descriptor
- `%sHDRS:\n` — header group
- BMOD template includes cross-references: `%.*sBLKS, %sHDRS, %sPALS`

### BMOD Entry Format

```
MODULEBMOD:
    .word   <width>,<height>,<block_count>
    .long   MODULEBLKS, HDRS_label, PALS_label
```

## Output Files

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
| Image TBLs (all 11 tables) | ✓ 100% |
| BGNDPAL.ASM palette data | ✓ palette names and colors match |
| BGNDEQU.H equates format | ✓ per-module W/H from module params |
| BGNDTBL.ASM labels | ✓ OLHDRS, BLKS, BMOD correct naming |
| BMOD `.word`/`.long` format | ✓ format matches LOADW |
| BMOD block count | ✗ object-to-module assignment pending |
| Image compression in IRW | ✓ FUN_1000_6f20 with LM/TM selection |
| HWDRS label derivation | ✓ last 2 chars of BDB name |
| Module hex detection | ✓ strtol-based, handles DPUL6 etc. |
| Module param parsing | ✓ all decimal integers

The palette data, world dimension equates, and label naming match the reference
exactly. The remaining gap is the object-to-module assignment logic needed to
correctly count blocks per module in BMOD entries.

## References

- `bddview.c` — Reference BDB/BDD viewer: https://github.com/Asure/midway-bddtool
- `bdd.md` — BDD/BDB format reference in this project
- `load2.hlp` — Original LOAD2 documentation (BBB> section)
- `src/loadimg.c` — BBB> handler at `process_lod()` (~400 lines)
