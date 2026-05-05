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

test_lod work2 ref2 MK2MIL "MK2MIL MKHH MKJC MKLK MKSA"
test_lod work2 ref3 MK3MIL "MK3MIL MKFN MKRD MKSA2 MKST"
test_lod work2 ref4 MK4MIL "MK4MIL MKGORO MKJX MKLK3 MKNJ MKRD2"
test_lod work2 ref5 MK5MIL "MK5MIL MKFN2 MKGORO2 MKRDWALK MKSK MKVOGEL MKZIP"
test_lod work5 ref6 MK6MIL "MK6MIL MKARMS MKBGANI MKBLOOD MKBONUS MKCOPY MKFALL MKFAT1 MKFAT2 MKFRIEND MKFX MKLK2 MKSEL MKSPLIT MKSUCK MKTEXT SCORAREA"
test_lod work2 ref7 MK7MIL "MK7MIL MKBABY MKBOLTS MKCHUNKS MKFATAL MKFLOORS MKFRND2 MKHUGE MKMK3 MKROCKS MKTC"
test_lod work2 ref8 MK8MIL "MK8MIL MKREVX"

echo ""
echo "=== $ALL_PASS pass, $ALL_FAIL fail ==="
exit $ALL_FAIL
