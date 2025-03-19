#!/usr/bin/env python3

import os
import sys
import subprocess
if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]
PRINT = os.getenv('PRINT', 'False').lower() in ('true', '1', 't')

# commit 93fd4aeb6fb8b03cad3ffdb539642c52a645acc7
# Author: Shen-Ta Hsieh <beststeve@secondstate.io>
# Date:   Thu Feb 1 14:57:13 2024 +0800

#     [JIT] Create interface class `Executable` to hold shared library, AOT section and JIT library in `Symbol`

#     * Move `Wrapper` and `IntrinsticsTable` into `Executable
#     * Split `SharedLibrary` into two class
#     * Remove LDMgr
#     * Add `loadExecutable` in `Loader`

#     Signed-off-by: Shen-Ta Hsieh <beststeve@secondstate.io>

# commit 4cbb3767a01c31d8756081290e56a7dbf4d8b1ec  --> CAN'T BUILD
# commit 58f4a624f6afa3cbd70661b30a2e54f6fe13e846 --> CAN'T BUILD
# commit 6ad56a4638c4cabeffd05c8d47a1905f0c24ebeb --> CAN'T BUILD

# commit q
# Author: hydai <z54981220@gmail.com>
# Date:   Tue Feb 13 16:09:13 2024 +0800

#     [OpenWrt] Bump the WasmEdge version and API version

#     Signed-off-by: hydai <z54981220@gmail.com>

def wrong_on_target():
    command = f'timeout 10s wasmedge-862fffd compile {WASM} wasmedge#3076.wasm.so && timeout 10s wasmedge-862fffd wasmedge#3076.wasm.so main'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
        errors='replace',            # Better handling of binary artifacts
    )
    if PRINT: print(result)
    expected_output = 'out of bounds memory access'
    if expected_output not in (result.stdout + result.stderr):
        return True
    else:
        return False

def correct_on_other():
    command = f'timeout 10s wasmedge-93fd4ae compile {WASM} wasmedge#3076.wasm.so && timeout 10s wasmedge-93fd4ae wasmedge#3076.wasm.so main'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
        errors='replace',            # Better handling of binary artifacts
    )
    if PRINT: print(result)
    expected_output = 'out of bounds memory access'
    if expected_output in result.stdout + result.stderr:
        return True
    else:
        return False

if not os.path.isfile(WASM):
    print(f"Error: The file {WASM} does not exist.")
    sys.exit(2)

if wrong_on_target() and correct_on_other():
    print("Interesting!")
    sys.exit(0)
else:
    print("Not interesting")
    sys.exit(1)
