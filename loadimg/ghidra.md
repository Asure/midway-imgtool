# Ghidra Analysis Guide — LOADW Reverse Engineering

## Current Status

### ZOF (Uncompressed) Mode — Byte-Exact Match

ZOF mode is **byte-exact** with LOADW across all tested datasets:
- MKSMALL (4 images): 100.0% (with and without `/P`)
- `/P` flag controls stride `(w+3)&~3` vs tight `w` packing in ZOF output

### ZON (Compressed) Mode

- MK2MIL, MK3MIL, MK4MIL: **100.0% byte-exact**
- MK5MIL, MK6MIL: **100.0% byte-exact** (checksum + encoder cascade fixes)
- MK7MIL: **100.0%** (background dedup + Y-offset + all 11 TBLs)
- BBB backgrounds (NUPOOL): **100.0% byte-exact**
- BBB backgrounds (TOMB/TOWER2): LM/TM selection differs

### Remaining Issues

| Issue | LODs | Status |
|-------|------|--------|
| CMP=1 encoder LM/TM selection | BB5, BB6, BB7 | Differs from LOADW for some compressed images |
| 16-bit checksum collision | BBMUG | 1/65536 collision on mugshot images |

## Ghidra Setup & Usage

### Prerequisites

- Ghidra 12.0+ (installed via snap: `snap install ghidra`)
- Project already exists at `/tmp/ghidra_proj3/LOADW.gpr` with LOADW.EXE imported
- Java scripts in `/tmp/ghidra_scripts2/`

### Running Headless Analysis

The snap wrapper (`/snap/bin/ghidra.analyzeHeadless`) does NOT find scripts correctly.
Use the **direct script** with `JAVA_HOME` set to Ghidra's bundled JDK:

```bash
JAVA_HOME=/snap/ghidra/35/usr/lib/jvm/java-21-openjdk-amd64 \
/snap/ghidra/35/ghidra_12.0_PUBLIC/support/analyzeHeadless \
  /tmp/ghidra_proj3 LOADW \
  -process LOADW.EXE \
  -postScript ScriptName.class \
  -scriptPath /tmp/ghidra_scripts2
```

Key points:
- Use `support/analyzeHeadless` NOT the snap wrapper
- Set `JAVA_HOME` to Ghidra's bundled JDK
- `-postScript` takes a **compiled `.class` file** (not `.java` — headless may fail to compile)
- `-scriptPath` adds directories to search

### Compiling Java Scripts

Scripts must be compiled before use because the headless analyzer may not find all Ghidra API dependencies:

```bash
GHIDRA_JARS=$(find /snap/ghidra/35/ghidra_12.0_PUBLIC -name '*.jar' | tr '\n' ':')
JAVA_HOME=/snap/ghidra/35/usr/lib/jvm/java-21-openjdk-amd64
cd /tmp/ghidra_scripts2
$JAVA_HOME/bin/javac -cp "$GHIDRA_JARS" -d . ScriptName.java
```

### Dumping Ghidra Symbols

To list all labels/functions known to Ghidra (includes COFF debug symbols if present):

```java
/*@category LOADW*/
import ghidra.program.model.listing.*;
import ghidra.program.model.symbol.*;
import ghidra.program.model.address.*;
import java.io.*;

public class DumpLabels extends ghidra.app.script.GhidraScript {
    @Override
    protected void run() throws Exception {
        PrintWriter out = new PrintWriter(new FileWriter("/tmp/ghidra_labels.txt"));
        var iter = currentProgram.getSymbolTable().getAllSymbols(false);
        int count = 0;
        while (iter.hasNext() && count < 5000) {
            var sym = iter.next();
            String name = sym.getName();
            Address addr = sym.getAddress();
            out.println(name + "|" + addr + "|" + sym.getSymbolType());
            count++;
        }
        out.close();
        println("Dumped " + count + " symbols to /tmp/ghidra_labels.txt");
    }
}
```

Usage:
```bash
JAVA_HOME=/snap/ghidra/35/usr/lib/jvm/java-21-openjdk-amd64 \
/snap/ghidra/35/ghidra_12.0_PUBLIC/support/analyzeHeadless \
  /tmp/ghidra_proj3 LOADW -process LOADW.EXE \
  -postScript DumpLabels.class -scriptPath /tmp/ghidra_scripts2
```

Known symbols found in Ghidra: `_packbits @ 1000:5b64`, `_do_zcom @ 1c9a:3102`.
COFF debug info in the binary also contains `_do_sclpad`, `_do_pad`, `_dataword`, `_do_table`, `_ctrl_word`, `_zero_pad`, `_do_align0`, `_do_cksum` and others, but Ghidra may not import all of them automatically.

### Headless Decompilation (Script in Home Dir)

If the script fails to load from `/tmp/` (OSGi class loading issue), copy it to `~/ghidra_scripts/`:

```bash
cp /tmp/ghidra_scripts2/DecompileBBB.java ~/ghidra_scripts/
JAVA_HOME=/snap/ghidra/35/usr/lib/jvm/java-21-openjdk-amd64 \
  /snap/ghidra/35/ghidra_12.0_PUBLIC/support/analyzeHeadless \
  /tmp/ghidra_proj3 LOADW -process LOADW.EXE \
  -scriptPath ~/ghidra_scripts -postScript DecompileBBB.java
```

The script's `println()` output goes to Ghidra's `INFO` log (stdout). Decompilation of large functions (like FUN_1854_1a49 at 1854:1a49, ~2100 lines) works but the decompiler may struggle with 16-bit far pointers and segmented memory.

### Script Template

Minimal working Java script for decompiling functions:

```java
/*@category LOADW*/
import ghidra.app.decompiler.DecompInterface;
import ghidra.util.task.ConsoleTaskMonitor;
import ghidra.program.model.listing.Function;
import ghidra.program.model.address.Address;

public class DumpFunc extends ghidra.app.script.GhidraScript {
    @Override
    protected void run() throws Exception {
        DecompInterface decomp = new DecompInterface();
        decomp.openProgram(currentProgram);

        String[] funcs = {"1000:6f20", "1000:5b64", "1000:7d25"};
        for (String fname : funcs) {
            Address addr = currentProgram.getAddressFactory().getAddress(fname);
            Function func = currentProgram.getFunctionManager().getFunctionAt(addr);
            if (func == null) { println(fname + ": not found"); continue; }
            println("\n=== " + fname + " ===");
            var res = decomp.decompileFunction(func, 60, new ConsoleTaskMonitor());
            if (res != null && res.getDecompiledFunction() != null)
                println(res.getDecompiledFunction().getC());
            else
                println("Decompile failed");
        }
    }
}
```

Python scripts (Jython) also work when placed in the script path, but Ghidra must be started with PyGhidra support (not available in headless mode by default).

## Key Functions

| Address | Name | Purpose |
|---------|------|---------|
| `1000:5b64` | `_packbits` | Main encode dispatch, row loop, calls FUN_1000_6f20 |
| `1000:6f20` | `FUN_1000_6f20` | LM/TM selection + second-pass lead/trail adjustment |
| `1000:7d25` | `FUN_1000_7d25` | Address space check (IRW fit) |
| `1000:77a8` | `FUN_1000_77a8` | Address management, SAG computation |
| `1000:5412` | `FUN_1000_5412` | Row pixel encoder (simple copy) |
| `1000:537f` | `FUN_1000_537f` | Row pixel encoder (with stride padding) |
| `1854:35fc` | `FUN_1854_35fc` | Checksum computation (DWORD sum + byte-pair max) |
| `1854:37dd` | `FUN_1854_37dd` | Checksum table lookup |
| `1854:38f9` | `FUN_1854_38f9` | Row writer (queues DMA commands) |
| `1000:7505` | `FUN_1000_7505` | Per-row lead/trail encoder |
| `1000:757c` | `FUN_1000_757c` | Lead computation helper |
| `1000:7727` | `FUN_1000_7727` | Row dispatch |
| `1c9a:3102` | `_do_zcom` | Zero-compression routine |
| `1854:1a49` | `FUN_1854_1a49` | BDD/BDB background processor (~3070 lines, decompiles to ~2100 lines). Handles object-module matching with inclusive extents (`x+w-1`, `y+h-1`), adjusts module ys to min object sy for Y-offset formula. See `/tmp/ghidra_bbb_decomp.txt`. |

## Internal Table Layout

FUN_1000_6f20 uses a per-row table at `param_3 + 0x234`:
- **First pass** (lines 87-88): stores raw values
  - `*(uint *)(row * 4 + 0x234) = lead`   — raw lead count
  - `*(uint *)(row * 4 + 0x236) = trail`  — raw trail count
- **Second pass** (line 112): overwrites with adjusted packed values
  - `*(uint *)(row * 4 + 0x234) = trail_n << 4 | lead_n`

## FUN_1000_6f20 Algorithm Summary

### First Pass (per-row lead/trail)
- Lead counts leading zeros, capped at 120 (`local_34 == 0x78` → bVar8=false)
- Trail counts trailing zeros after lead finishes, resets on non-zero
- Pixel stride between rows: `sizx + (-sizx & 3)` (4-byte aligned)
- Raw lead/trail stored to table at `0x234`/`0x236`

### LM/TM Selection
- Errors computed as `sum(lead - lead_c)` for each multiplier (×1, ×2, ×4, ×8)
- LM selected by minimum lead_err (`<` comparison, strict)
- TM selected by minimum trail_err (`<=` comparison, keep current on tie)
- Return value encodes LM, TM, and CMP bit

### Second Pass (minimum stored = 10 adjustment)
- Reads raw lead/trail from table
- Quantizes by selected LM/TM: `lead_n = lead / mult`, `trail_n = trail / mult`
- If `stored = sizx - lead_c - trail_c < 10`:
  - `need = 10 - stored`
  - First reduces `lead_n` (up to `lead_c` pixels)
  - If still < 10, reduces `trail_n` (remaining need)
- Stores adjusted `trail_n << 4 | lead_n` back to table
- Accumulates total compressed bits for fit check

## Known Ghidra Issues

- The snap wrapper (`/snap/bin/ghidra.analyzeHeadless`) cannot find scripts; use the direct `support/analyzeHeadless` with `JAVA_HOME` set instead
- Java scripts must be pre-compiled with `javac`; the headless compiler may fail on scripts with complex dependencies
- `-postScript` takes `.class` (compiled), not `.java` — the headless analyzer's built-in compiler may not find all Ghidra API dependencies
- 16-bit far real-mode decompilation has limitations: pointer arithmetic (`CONCAT22`) may be opaque, switch jump tables are often unreachable
- Decompiler may strip loop bodies when it can't track loop variable bounds
- Cross-segment string references (format strings in `45e8` segment, code in `1000`/`1854`/`1c9a`) are not resolved, so literal content search won't find them
- COFF debug symbols from the Borland C++ 4.5 toolchain (e.g. `_do_sclpad`, `_do_pad`, `_dataword`, `_do_table`) exist in the binary but Ghidra may not import them all. Only `_packbits` (1000:5b64) and `_do_zcom` (1c9a:3102) are auto-imported.
- BBB COFF symbols found at file offsets: `_bgnd_mod` (0x3bcc9), `_bgnd_block` (0x3bd40), `_bgnd_cksum_match` (0x3bdb7), `_bgnd_cksum_bits` (0x3be9e), `_do_rawbgndj` (0x3bfec), `_bgndtbl` (0x3c11a). These are in the COFF debug symbol table but Ghidra may not auto-import them.

## Files

- `/tmp/ghidra_proj3/` — Ghidra project (LOADW.EXE analyzed)
- `/tmp/ghidra_scripts2/` — Java analysis scripts
- `/tmp/ghidra_packbits_new.txt` — Main `_packbits` decompilation
- `/tmp/ghidra_rowenc.txt` — Row writer (FUN_1854_38f9)
- `/tmp/func_6f20_full.txt` — FUN_1000_6f20 full decompilation
- `/tmp/decomp_checksum_lead.txt` — FUN_1000_6f20 (earlier analysis)
- `/tmp/ghidra_con_dedup.txt` — Checksum functions
- `/tmp/ghidra_7505.txt` — FUN_1000_7505 (per-row encoder)
- `/tmp/ghidra_bbb_decomp.txt` — FUN_1854_1a49 BBB handler decompilation (2125 lines)
- `/tmp/bbb_label_analysis.txt` — BBB string cross-reference analysis
- `/tmp/bbb_compression_analysis.txt` — BBB compression path analysis
