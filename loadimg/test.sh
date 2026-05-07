#!/bin/bash
# loadimg test runner — compares output against LOADW references

BASE="$(cd "$(dirname "$0")" && pwd)"
TOOL="$BASE/build/loadimg"

if [ ! -f "$TOOL" ]; then
    echo "ERROR: build loadimg first: cd $BASE/build && cmake ../src && make"
    exit 1
fi

echo "=== loadimg test suite ==="
echo ""

ALL_PASS=0; ALL_FAIL=0

test_lod() {
    local WORKDIR="$1" REFDIR="$2" LODNAME="$3" TBL_LIST="$4"
    cd "$BASE/$WORKDIR" 2>/dev/null || { echo "  SKIP $LODNAME: no $WORKDIR"; return; }

    rm -f "$LODNAME.IRW" *.TBL IMGTBL.ASM IMGTBL.GLO IMGPAL.ASM 2>/dev/null
    if ! timeout 180 "$TOOL" "$LODNAME.LOD" /P /T 2>/dev/null; then
        echo "  FAIL $LODNAME: tool error"; ALL_FAIL=$((ALL_FAIL + 1)); return
    fi

    PASS=0; FAIL=0
    for T in $TBL_LIST; do
        REF="$BASE/$REFDIR/$T.TBL"
        if [ -f "$REF" ] && [ -f "$T.TBL" ]; then
            if diff "$REF" "$T.TBL" >/dev/null 2>&1; then
                PASS=$((PASS + 1))
            else
                FAIL=$((FAIL + 1))
            fi
        fi
    done

    if [ $FAIL -eq 0 ]; then
        echo "  PASS $LODNAME: $PASS/$((PASS+FAIL)) TBLs"
        ALL_PASS=$((ALL_PASS + 1))
    else
        echo "  FAIL $LODNAME: $PASS/$((PASS+FAIL)) TBLs"
        ALL_FAIL=$((ALL_FAIL + 1))
    fi
}

test_lod work5 ref2 MK2MIL "MK2MIL MKHH MKJC MKLK MKSA"
test_lod work5 ref3 MK3MIL "MK3MIL MKFN MKRD MKSA2 MKST"
test_lod work5 ref4 MK4MIL "MK4MIL MKGORO MKJX MKLK3 MKNJ MKRD2"
test_lod work5 ref5 MK5MIL "MK5MIL MKFN2 MKGORO2 MKRDWALK MKSK MKVOGEL MKZIP"
test_lod work5 ref6 MK6MIL "MK6MIL MKARMS MKBGANI MKBLOOD MKBONUS MKCOPY MKFALL MKFAT1 MKFAT2 MKFRIEND MKFX MKLK2 MKSEL MKSPLIT MKSUCK MKTEXT SCORAREA"
test_lod work5 ref7 MK7MIL "MK7MIL MKBABY MKBOLTS MKCHUNKS MKFATAL MKFLOORS MKFRND2 MKHUGE MKMK3 MKROCKS MKTC"
test_lod work5 ref8 MK8MIL "MK8MIL MKREVX"

# workArt: BB* LODs from NBA Jam TE / Hangtime
test_lod workArt refArt BB "PLYRHD PLYRHD2"
test_lod workArt refArt BB2 "CROWD PLAQUES PLYRSEQ"
test_lod workArt refArt BB3 "BEHIND PASS"
test_lod workArt refArt BB4 "FLAIL"
test_lod workArt refArt BB5 "PLYRDSP PLYRDSEQ STAND PLYRSEQ2 PLYRSEQ3 PLYRJSHT PLYRMAKE"
test_lod workArt refArt BB6 "NAMES2 PLYRDSQ2 NCKNME PRIVLG CHEER PLYRHD6A"
test_lod workArt refArt BB7 "ARROW MUGSHOT HOTSPOT BALLSHAD BALL LOGOS CREDTURB CREDIT HOOP COURTFLR HANGFONT BASTCYC PLYRNUB PRIZES POWERTXT OUTDOOR"
test_lod workArt refArt BB8 "PLYRRSEQ PLYRHD6 MUGSHOT8"
test_lod workArt refArt BBMUG "PLYRHD3 PLYRHD5"
test_lod workArt refArt BBVDA "BBVDA"

# BBPAL is palette-only (ASM> junkxxxx, no TBL output)
# workht: misc.lod from NBA Jam/Hangtime (headerless, dual-bank)
test_lod_workht() {
    local REFDIR="refht" LODNAME="misc"
    cd "$BASE/workht" 2>/dev/null || { echo "  SKIP MISC: no workht"; return; }

    rm -rf folder "$LODNAME.IRW" 2>/dev/null
    mkdir -p folder
    if ! timeout 180 "$TOOL" "$LODNAME.lod" /T=folder /F /E 2>/dev/null; then
        echo "  FAIL MISC: tool error"; ALL_FAIL=$((ALL_FAIL + 1)); return
    fi

    PASS=0; FAIL=0
    for tbl in BBVDA COWERING CROWD2 DCS HOOP2 LIGHTEN NAMES3 NEWHEADS NEWMUGS \
               PLYRDSQ3 PLYRPBCK SHANG SHATTER STEALUP STORM TEAMZONE UGROUND UGROUND1; do
        if diff "$BASE/$REFDIR/${tbl}.TBL" "folder/${tbl}.TBL" >/dev/null 2>&1; then
            PASS=$((PASS + 1))
        else
            FAIL=$((FAIL + 1))
        fi
    done
    # Also check global tables
    for f in IMGTBL.ASM IMGPAL.ASM IMGTBL.GLO; do
        if diff "$BASE/$REFDIR/$f" "folder/$f" >/dev/null 2>&1; then
            PASS=$((PASS + 1))
        else
            FAIL=$((FAIL + 1))
        fi
    done

    if [ $FAIL -eq 0 ]; then
        echo "  PASS MISC: $PASS/$((PASS+FAIL)) files"
        ALL_PASS=$((ALL_PASS + 1))
    else
        echo "  FAIL MISC: $PASS/$((PASS+FAIL)) files"
        ALL_FAIL=$((ALL_FAIL + 1))
    fi
}
test_lod_workht

echo ""
echo "=== $ALL_PASS pass, $ALL_FAIL fail ==="
exit $ALL_FAIL
