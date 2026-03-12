#!/usr/bin/env python3
"""
img_convert.py  —  Convert Midway/Williams old-format .IMG files
                   (pre-WimpV5, 42-byte IMAGE, near pointers, VERSION=0)
                   to new-format .IMG files
                   (WimpV6.34, 50-byte IMAGE, far pointers, TEMP=0xABCD).

Field mapping  (old → new):
  name_s  → N_s       xoff  → ANIX     yoff  → ANIY
  xsize   → W         ysize → H        palind → PALNUM
  flags   → FLAGS      oset  → OSET     data  → DATA
  lib     → LIB       pword1 → ANIX2   pword2 → ANIY2
  frame   → FRM       (new) ANIZ2=0, PTTBLNUM=0xFFFF, OPALS=0xFFFF

Usage:
  python img_convert.py  input.IMG  [output.IMG]
  (output defaults to input_new.IMG)
"""

import sys, struct, os

# ── Format constants (wmpstruc.inc) ───────────────────────────────────────────
IMGVER_NEW  = 0x0634    # IMGVER equ 634h
TEMP_MAGIC  = 0xABCD    # marks "version is valid"

# LIB_HDR  (struct 2 → 2-byte alignment → no padding between H and I)
# IMGCNT PALCNT OSET VERSION SEQCNT SCRCNT DAMCNT TEMP BUFSCR(4) spare×3
LIB_HDR_FMT  = '<HHIHHHHH4sHHH'
LIB_HDR_SIZE = struct.calcsize(LIB_HDR_FMT)   # 28

# Old IMG (commented-out struct, 42 bytes, struct 2)
# name_s(16) xoff yoff xsize ysize palind flags oset data lib pword1 pword2 frame pbyte1
OLD_IMG_FMT  = '<16shhHHbbIIhhhbb'
OLD_IMG_SIZE = struct.calcsize(OLD_IMG_FMT)    # 42

# New IMAGE (struct 2, 50 bytes)
# N_s(16) FLAGS ANIX ANIY W H PALNUM OSET DATA LIB ANIX2 ANIY2 ANIZ2 FRM PTTBLNUM OPALS
NEW_IMG_FMT  = '<16sHHHHHHIIHHHHHHH'
NEW_IMG_SIZE = struct.calcsize(NEW_IMG_FMT)    # 50

# PALETTE (struct 2, 26 bytes — identical in both formats)
PAL_FMT  = '<10sBBHIHHBBH'
PAL_SIZE = struct.calcsize(PAL_FMT)            # 26

assert LIB_HDR_SIZE == 28, LIB_HDR_SIZE
assert OLD_IMG_SIZE == 42, OLD_IMG_SIZE
assert NEW_IMG_SIZE == 50, NEW_IMG_SIZE
assert PAL_SIZE     == 26, PAL_SIZE


# ── Helpers ───────────────────────────────────────────────────────────────────

def parse_hdr(data):
    f = struct.unpack_from(LIB_HDR_FMT, data, 0)
    return dict(zip(
        ('IMGCNT','PALCNT','OSET','VERSION','SEQCNT','SCRCNT',
         'DAMCNT','TEMP','BUFSCR','spare1','spare2','spare3'), f))

def pack_hdr(h):
    return struct.pack(LIB_HDR_FMT,
        h['IMGCNT'], h['PALCNT'], h['OSET'], h['VERSION'],
        h['SEQCNT'], h['SCRCNT'], h['DAMCNT'], h['TEMP'],
        h['BUFSCR'], h['spare1'], h['spare2'], h['spare3'])

def parse_old_images(data, base, count):
    imgs = []
    off  = base
    for _ in range(count):
        f = struct.unpack_from(OLD_IMG_FMT, data, off)
        imgs.append(dict(zip(
            ('name','xoff','yoff','xsize','ysize',
             'palind','flags','oset','data',
             'lib','pword1','pword2','frame','pbyte1'), f)))
        off += OLD_IMG_SIZE
    return imgs

def convert_image(o):
    """Map old IMG fields to new IMAGE; new-only fields get safe defaults."""
    flags  = o['flags']  & 0xFF
    flags &= ~0x12        # clear LOADED(2) and DOWN(10h) — runtime-only

    return struct.pack(NEW_IMG_FMT,
        o['name'],               # N_s   (16 bytes, already bytes)
        flags,                   # FLAGS
        o['xoff']   & 0xFFFF,   # ANIX
        o['yoff']   & 0xFFFF,   # ANIY
        o['xsize']  & 0xFFFF,   # W
        o['ysize']  & 0xFFFF,   # H
        o['palind'] & 0xFF,     # PALNUM  (was signed byte index)
        o['oset']   & 0xFFFFFFFF,  # OSET
        o['data']   & 0xFFFFFFFF,  # DATA
        o['lib']    & 0xFFFF,   # LIB
        o['pword1'] & 0xFFFF,   # ANIX2  (packed cbox → 2nd anipt X)
        o['pword2'] & 0xFFFF,   # ANIY2
        0,                       # ANIZ2   (no equivalent in old format)
        o['frame']  & 0xFF,     # FRM
        0xFFFF,                  # PTTBLNUM = -1 (no point table)
        0xFFFF,                  # OPALS    = no alternate palette
    )


# ── Main conversion ───────────────────────────────────────────────────────────

def convert(inpath, outpath):
    with open(inpath, 'rb') as fh:
        data = fh.read()

    if len(data) < LIB_HDR_SIZE:
        sys.exit(f'Error: file too small ({len(data)} bytes)')

    hdr = parse_hdr(data)

    # Sanity checks
    if hdr['TEMP'] == TEMP_MAGIC:
        sys.exit('Already new format (TEMP=0xABCD). Nothing to do.')
    if hdr['VERSION'] >= 0x500:
        print(f'Warning: VERSION=0x{hdr["VERSION"]:X} — may already be new format.',
              file=sys.stderr)

    oset = hdr['OSET']
    if oset > len(data):
        sys.exit(f'Error: OSET 0x{oset:X} beyond file end 0x{len(data):X}')

    print(f'Input    : {inpath}  ({len(data)} bytes)')
    print(f'Version  : 0x{hdr["VERSION"]:04X}   TEMP: 0x{hdr["TEMP"]:04X}')
    print(f'Images   : {hdr["IMGCNT"]}   Palettes: {hdr["PALCNT"]}')
    print(f'Seqs     : {hdr["SEQCNT"]}   Scripts : {hdr["SCRCNT"]}')
    print(f'OSET     : 0x{oset:X}')

    # ── Slice the input file ──────────────────────────────────────────────────
    # Layout: [LIB_HDR(28)] [blob data] [IMAGE×N] [PALETTE×P] [seq/scr data?]

    blob_data = data[LIB_HDR_SIZE : oset]

    imgs_end  = oset + hdr['IMGCNT'] * OLD_IMG_SIZE
    pals_end  = imgs_end + hdr['PALCNT'] * PAL_SIZE

    if pals_end > len(data):
        sys.exit(f'Error: metadata tables extend beyond file end '
                 f'(need 0x{pals_end:X}, have 0x{len(data):X})')

    old_imgs  = parse_old_images(data, oset, hdr['IMGCNT'])
    pal_blob  = data[imgs_end : pals_end]     # PALETTE structs unchanged

    dropped_seqs = hdr['SEQCNT']
    dropped_scrs = hdr['SCRCNT']
    if dropped_seqs or dropped_scrs:
        print(f'Note     : dropping {dropped_seqs} seq(s) + {dropped_scrs} script(s) '
              f'(old ANIM_SEQ layout incompatible with new SEQSCR — not convertible).')

    # ── Build output ──────────────────────────────────────────────────────────
    new_hdr            = dict(hdr)
    new_hdr['VERSION'] = IMGVER_NEW
    new_hdr['TEMP']    = TEMP_MAGIC
    new_hdr['SEQCNT']  = 0       # drop incompatible old sequence data
    new_hdr['SCRCNT']  = 0
    # OSET unchanged: blob data sits at the same file position

    new_imgs = b''.join(convert_image(img) for img in old_imgs)

    out = pack_hdr(new_hdr) + blob_data + new_imgs + pal_blob
    # (tail / old ANIM_SEQ pool intentionally omitted)

    with open(outpath, 'wb') as fh:
        fh.write(out)

    delta = len(out) - len(data)
    print(f'Output   : {outpath}  ({len(out)} bytes, {delta:+d})')
    print('Done.')


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(0)

    src = sys.argv[1]
    dst = sys.argv[2] if len(sys.argv) > 2 else (
        os.path.splitext(src)[0] + '_new.IMG')

    convert(src, dst)
