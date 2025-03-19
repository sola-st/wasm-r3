#!/usr/bin/env python3

import os
import sys
import subprocess
if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]
PRINT = os.getenv('PRINT', 'False').lower() in ('true', '1', 't')

# commit 718f0671e7e62eeab3b57899c43a9530e89aff63 (HEAD)
# Author: liang.he <liang.he@intel.com>
# Date:   Fri Dec 1 11:14:13 2023 +0800

#     Output warning and quit if import/export name contains '\00' (#2806)

#     Leave it as a limitation when import/export name contains '\00' in wasm file.
#     p.s. https://github.com/bytecodealliance/wasm-micro-runtime/issues/2789

# commit 873558c40edc60731fd9091722681e5e54bbe95c
# Author: Enrico Loparco <eloparco@amazon.com>
# Date:   Thu Nov 30 00:49:58 2023 +0000

#     Get rid of compilation warnings and minor doc fix (#2839)

def wrong_on_target():
    command = f'wamrc-873558c -o wamr#2789.wasm.aot {WASM}'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    if PRINT: print(result)
    expected_result = 'WASM module load failed: duplicate export name'
    if expected_result in result.stdout:
        return True
    else:
        return False

def correct_on_other():
    command = f'wamrc-718f067 -o wamr#2789.wasm.aot {WASM}'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    if PRINT: print(result)
    expected_result = 'WASM module load failed: duplicate export name'
    if expected_result not in result.stdout:
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
