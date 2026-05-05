# BDD / BDB File Format Reference

Formats used by the Midway TMS34010-based arcade toolchain, documented from
*Mortal Kombat* and *Mortal Kombat II* data.

---

## BDD — Binary Image Container

A mixed text/binary file. All text lines are newline-terminated (`\n`).

```
<count>\n
<idx_hex> <w> <h> <dma_bit0>\n   ← one header per image
<w × h bytes of raw pixel data>  ← 8-bit palette-indexed pixels, row-major
... repeat for each image ...
<PAL_NAME> <count>\n             ← palette header (ASCII name + entry count)
<count × 2 bytes>                ← BGR555 colour entries, 16-bit little-endian
... repeat for each palette ...
```

### Image section

The first line is a decimal count of images (consumed but not validated by the
viewer — actual count is determined by sequential reads).

Each image record:

1. **Header line** (ASCII text)

   | Token | Format | Description |
   |---|---|---|
   | `idx` | hex | Lookup key matched by the BDB `ii` field |
   | `w` | decimal | Width in pixels (`1`–`4096`) |
   | `h` | decimal | Height in pixels (`1`–`4096`) |
   | `dma_bit0` | `0` or `1` | Bit 0 of the TMS34010 DMA control word |

2. **Pixel data** (binary, immediately follows the header newline)

   `w × h` bytes, row-major, top-to-bottom. Each byte is a palette index
   (0–255). Index 0 is always transparent.

### Palette section

Each palette record:

1. **Header line** (ASCII text): `<PAL_NAME> <count>\n`
   - `PAL_NAME` — arbitrary ASCII label (assembly symbol name in original data)
   - `count` — number of colour entries that follow (max 256)

2. **Colour data** (binary): `count × 2` bytes, little-endian 16-bit BGR555

#### BGR555 entry layout

```
bit    15      unused (always 0)
bits 14-10     red   (5 bits)
bits  9- 5     green (5 bits)
bits  4- 0     blue  (5 bits)
```

Convert to 8-bit per channel by left-shifting 3 (multiply by 8):

```
r8 = (entry >> 10) & 0x1F) << 3
g8 = (entry >>  5) & 0x1F) << 3
b8 = (entry        & 0x1F) << 3
```

### Limits

| Item | Max |
|---|---|
| Images per file | 256 |
| Palettes per file | 64 |
| Entries per palette | 256 |
| Image dimension | 4096 × 4096 |

---

## BDB — Object Placement List

Pure ASCII. All fields on a line are whitespace-separated.

```
<world_name> <w> <h> <max_depth> <num_modules> <num_pals> <num_objects>
<mod_name> <depth_base> <scroll_x> <sy_base> <sy_span>
... one module line per module (num_modules total) ...
<wx_hex> <depth> <sy> <ii_hex> <fl>
... one object line per object (num_objects total) ...
```

### World header (line 1)

| Field | Format | Description |
|---|---|---|
| `world_name` | string | Scene identifier |
| `w` | decimal | World scroll width in pixels |
| `h` | decimal | World scroll height in pixels |
| `max_depth` | decimal | Maximum depth value (typically 255) |
| `num_modules` | decimal | Module lines that follow (0 in older files) |
| `num_pals` | decimal | Number of palettes in the matching BDD |
| `num_objects` | decimal | Object lines that follow |

### Module lines (num_modules lines)

Describe rectangular regions of the world associated with an assembly module.

| Field | Format | Description |
|---|---|---|
| `mod_name` | string | Module name (assembly symbol `<NAME>BMOD`) |
| `depth_base` | decimal | World depth of the module's left edge |
| `scroll_x` | decimal | Horizontal scroll register position |
| `sy_base` | decimal | Screen Y of the module's top edge |
| `sy_span` | decimal | Height of the module in screen pixels |

### Object lines (num_objects lines)

One sprite placement per line.

| Field | Format | Description |
|---|---|---|
| `wx` | hex (no prefix) | TMS34010 DMA control word |
| `depth` | decimal | Horizontal world position (X axis) |
| `sy` | decimal | Screen Y position |
| `ii` | hex (no prefix) | Image index — must match an `idx` in the BDD |
| `fl` | decimal | Palette index (0-based, selects BDD palette in file order) |

### Limits

| Item | Max |
|---|---|
| Objects per file | 1024 |
| Module lines | 32 |

---

## TMS34010 DMA Control Word (`wx`)

16-bit value written as bare hex in BDB object lines.

```
bit  15      DGO   DMA go/halt
bits 14-12   PIX   Pixel size (000 = 8-bit indexed)
bit  11      TM1   Compress trail pixel multiplier bit 1
bit  10      TM0   Compress trail pixel multiplier bit 0
bit   9      LM1   Compress lead pixel multiplier bit 1
bit   8      LM0   Compress lead pixel multiplier bit 0
bit   7      CMP   Compress mode
bit   6      CLP   Clip enable
bit   5      VFL   Vertical flip
bit   4      HFL   Horizontal flip
bits  3- 0   OPS   Pixel ops
```

The **high byte** (bits 15–8) encodes the parallax scroll rate. Objects with a
lower high byte are drawn further back (behind) objects with a higher high byte.

Flip bits are extracted from `wx` at load time:
- bit 4 → `hfl` (horizontal flip)
- bit 5 → `vfl` (vertical flip)

### Common high-byte values (Mortal Kombat backgrounds)

| High byte | Typical `wx` | Layer |
|---|---|---|
| `0x32` | `0x3200` | Slow far background |
| `0x3C` | `0x3C00` | Mid background |
| `0x40` | `0x4000` | Main play layer |
| `0x41` | `0x4100` | Main play layer (alt) |
| `0x43` | `0x4300` | Slightly closer |
| `0x46` | `0x4600` | Near foreground |

---

## Coordinate System

| BDB field | Axis | Direction |
|---|---|---|
| `depth` | X (horizontal) | Increases left-to-right |
| `sy` | Y (vertical) | Screen Y, increases downward |

Draw order: sorted by `wx` high byte ascending (furthest layer first), with
original BDB file order preserved within each layer.

---

## Palette Assignment

Each object's `fl` field is a 0-based index into the BDD palette list (in file
order). When the same image `idx` appears in multiple objects with different
`fl` values, the **first** assignment wins — subsequent `fl` values for that
image are ignored.

---

## TGA Import (bddview extension)

To add a new sprite at runtime, import an **8-bit paletted TGA** (type 1) with
a **15-bit BGR555 colour map** (16-bit colour map depth field = 15 or 16).
The viewer appends the new image and its palette to the BDD file on disk,
creating a `.BAK` backup first.

TGA header fields used:

| Offset | Size | Field |
|---|---|---|
| 0 | 1 | ID length |
| 1 | 1 | Colour map type (must be 1) |
| 2 | 1 | Image type (must be 1 = uncompressed paletted) |
| 5–6 | 2 | Colour map entry count (LE) |
| 7 | 1 | Colour map entry depth (bits) |
| 12–13 | 2 | Width (LE) |
| 14–15 | 2 | Height (LE) |
| 16 | 1 | Pixel depth (must be 8) |
| 17 | 1 | Image descriptor |
