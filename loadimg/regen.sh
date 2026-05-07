#!/bin/bash
# Regenerate LOADW reference files via DOSBox
# Usage: ./regen.sh [lod_name]   (e.g. ./regen.sh MK7MIL)
# If no arg given, regenerates all (MK2MIL..MK8MIL, MKBBB)

BASE="$(cd "$(dirname "$0")" && pwd)"
WORK5="$BASE/work5"
DOSBOX="dosbox"

loadw_regen() {
    local LODNAME="$1" REFDIR="$2"
    local TMPDIR="/tmp/loadw_regen_$$"
    
    echo "=== Regenerating $LODNAME -> $REFDIR ==="
    
    # Clean and copy fresh data
    rm -rf "$TMPDIR"
    cp -a "$WORK5" "$TMPDIR"
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
LOADW $LODNAME /P /F=C:\\TMP /T=C:\\TMP /V5> C:\\TMP\\OUT.TXT
exit
EOF
    
    # Run DOSBox
    cd "$TMPDIR"
    $DOSBOX -conf dosbox.conf -noconsole -c exit 2>/dev/null
    cd "$BASE"
    
    # Copy outputs to ref directory
    mkdir -p "$REFDIR"
    cp "$TMPDIR/TMP/"*.TBL "$REFDIR/" 2>/dev/null
    cp "$TMPDIR/TMP/"*.IRW "$REFDIR/" 2>/dev/null
    cp "$TMPDIR/TMP/"*.ASM "$REFDIR/" 2>/dev/null
    cp "$TMPDIR/TMP/"*.GLO "$REFDIR/" 2>/dev/null
    cp "$TMPDIR/TMP/"*.H "$REFDIR/" 2>/dev/null
    cp "$TMPDIR/TMP/OUT.TXT" "$REFDIR/" 2>/dev/null
    
    # Cleanup
    rm -rf "$TMPDIR"
    echo "  -> $REFDIR updated"
}

if [ $# -ge 1 ]; then
    case "$1" in
        MK2MIL) loadw_regen MK2MIL ref2 ;;
        MK3MIL) loadw_regen MK3MIL ref3 ;;
        MK4MIL) loadw_regen MK4MIL ref4 ;;
        MK5MIL) loadw_regen MK5MIL ref5 ;;
        MK6MIL) loadw_regen MK6MIL ref6 ;;
        MK7MIL) loadw_regen MK7MIL ref7 ;;
        MK8MIL) loadw_regen MK8MIL ref8 ;;
        MKBBB)  loadw_regen MKBBB refBBB ;;
        *) echo "Unknown LOD: $1"; exit 1 ;;
    esac
else
    loadw_regen MK2MIL ref2
    loadw_regen MK3MIL ref3
    loadw_regen MK4MIL ref4
    loadw_regen MK5MIL ref5
    loadw_regen MK6MIL ref6
    loadw_regen MK7MIL ref7
    loadw_regen MK8MIL ref8
    loadw_regen MKBBB refBBB
fi
