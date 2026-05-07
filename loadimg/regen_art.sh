#!/bin/bash
# Regenerate BB* LOD reference files via DOSBox for workArt/
BASE="$(cd "$(dirname "$0")" && pwd)"
WORKART="$BASE/workArt"
REFDIR="$BASE/refArt"
DOSBOX="dosbox"
TMPDIR_BASE="/tmp/bbb_ref"

mkdir -p "$REFDIR"

loadw_regen_art() {
    local LODNAME="$1"
    local TMPDIR="${TMPDIR_BASE}_$$"

    echo "=== Regenerating $LODNAME -> refArt/ ==="

    # Clean and copy fresh data
    rm -rf "$TMPDIR"
    mkdir -p "$TMPDIR"
    cp -a "$WORKART/." "$TMPDIR/"
    cp "$BASE/binary/LOADW.EXE" "$TMPDIR/"

    # Create DOSBox config
    cat > "$TMPDIR/dosbox.conf" << EOF
[dosbox]
machine=svga_s3
memsize=16
[cpu]
core=auto
cputype=auto
cycles=max
[autoexec]
mount c $TMPDIR
c:
md TMP
LOADW $LODNAME /P /F=C:\\TMP /T=C:\\TMP /V5 > C:\\TMP\\OUT.TXT
exit
EOF

    # Run DOSBox
    cd "$TMPDIR"
    $DOSBOX -conf dosbox.conf -noconsole -c exit 2>/dev/null
    cd "$BASE"

    # Copy outputs to refArt directory
    shopt -s nullglob
    tbl_files=("$TMPDIR/TMP/"*.TBL)
    irw_files=("$TMPDIR/TMP/"*.IRW)
    asm_files=("$TMPDIR/TMP/"*.ASM)
    glo_files=("$TMPDIR/TMP/"*.GLO)
    h_files=("$TMPDIR/TMP/"*.H)
    [ ${#tbl_files[@]} -gt 0 ] && cp "${tbl_files[@]}" "$REFDIR/"
    [ ${#irw_files[@]} -gt 0 ] && cp "${irw_files[@]}" "$REFDIR/"
    [ ${#asm_files[@]} -gt 0 ] && cp "${asm_files[@]}" "$REFDIR/"
    [ ${#glo_files[@]} -gt 0 ] && cp "${glo_files[@]}" "$REFDIR/"
    [ ${#h_files[@]} -gt 0 ] && cp "${h_files[@]}" "$REFDIR/"
    [ -f "$TMPDIR/TMP/OUT.TXT" ] && cp "$TMPDIR/TMP/OUT.TXT" "$REFDIR/${LODNAME}_OUT.TXT"

    # Cleanup
    rm -rf "$TMPDIR"
    echo "  -> refArt/ updated ($LODNAME)"
}

# Regenerate all BB* LODs
loadw_regen_art BB
loadw_regen_art BB2
loadw_regen_art BB3
loadw_regen_art BB4
loadw_regen_art BB5
loadw_regen_art BB6
loadw_regen_art BB7
loadw_regen_art BB8
loadw_regen_art BBMUG
loadw_regen_art BBPAL
loadw_regen_art BBVDA

echo "=== All BB* LODs regenerated in refArt/ ==="
ls "$REFDIR/"
