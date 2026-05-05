# Ghidra Analysis Guide — LOADW Reverse Engineering

## Current Status

### ZOF (Uncompressed) Mode — Byte-Exact Match

ZOF mode is **byte-exact** with LOADW across all tested datasets:
- MKSMALL (4 images): 100.0% (with and without `/P`)
- `/P` flag controls stride `(w+3)&~3` vs tight `w` packing in ZOF output

### ZON (Compressed) Mode — Partial Match

- MK2MIL, MK4MIL, MK8MIL: **100.0% byte-exact** (IRW + all TBLs)
- MK3MIL, MK5MIL, MK6MIL, MK7MIL: **partial** — LM/TM selection now matches LOADW
  (FUN_1000_6f20 trail counting uses `else if`, not double-if, fixing TE values),
  but an encoder cascade remains (~3-31 bytes per TBL per LOD)
- Space check: CMP=0 when compressed size >= raw size (`<=` comparison)
- Minimum stored=10 adjustment fully implemented (local_2c/iVar9 distribution)

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
  -postScript ScriptName.java \
  -scriptPath /tmp/ghidra_scripts2
```

Key points:
- Use `support/analyzeHeadless` NOT the snap wrapper
- Set `JAVA_HOME` to Ghidra's bundled JDK
- `-postScript` takes script name **with `.java` extension**
- `-scriptPath` adds directories to search

### Compiling Java Scripts

Scripts must be compiled before use (Ghidra's headless compiler may not find all dependencies):

```bash
GHIDRA_JARS=$(find /snap/ghidra/35/ghidra_12.0_PUBLIC -name '*.jar' | tr '\n' ':')
JAVA_HOME=/snap/ghidra/35/usr/lib/jvm/java-21-openjdk-amd64
cd /tmp/ghidra_scripts2
$JAVA_HOME/bin/javac -cp "$GHIDRA_JARS" -d . ScriptName.java
```

### Script Template

Minimal working Java script for decompiling functions:

```java
/*@category LOADW*/
import ghidra.app.decompiler.DecompInterface;
import ghidra.util.task.ConsoleTaskMonitor;
import ghidra.program.model.listing.Function;
import ghidra.program.model.address.Address;

public class DumpFunc extends GhidraScript {
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

Python scripts also work (Jython), placed in the same script path.

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
- 16-bit far real-mode decompilation has limitations: pointer arithmetic (`CONCAT22`) may be opaque, and switch jump tables are often unreachable
- Decompiler may strip loop bodies when it can't track loop variable bounds

## Files

- `/tmp/ghidra_proj3/` — Ghidra project (LOADW.EXE analyzed)
- `/tmp/ghidra_scripts2/` — Java analysis scripts
- `/tmp/ghidra_packbits_new.txt` — Main `_packbits` decompilation
- `/tmp/ghidra_rowenc.txt` — Row writer (FUN_1854_38f9)
- `/tmp/func_6f20_full.txt` — FUN_1000_6f20 full decompilation
- `/tmp/decomp_checksum_lead.txt` — FUN_1000_6f20 (earlier analysis)
- `/tmp/ghidra_con_dedup.txt` — Checksum functions
- `/tmp/ghidra_7505.txt` — FUN_1000_7505 (per-row encoder)
