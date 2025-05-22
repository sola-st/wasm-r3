#!/usr/bin/env python3

import os
import sys
import subprocess
if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]
PRINT = os.getenv('PRINT', 'False').lower() in ('true', '1', 't')

# commit ccf0c5622ed3acba83fd2c8b8612edc072a3438c
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Wed Feb 8 10:06:03 2023 -0500

#     [jit] Fix register constraint in call sequence

# commit 25abe41f3d6e3db22e22584dbd645a51f9978b14 (HEAD)
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Tue Feb 7 21:12:48 2023 -0500

#     [simd] Fix CodeValidator for load/store signatures

def wrong_on_target():
    command = f'timeout 10s wizard-25abe41 -mode=jit {WASM}'
    # command = f'timeout 10s /home/<anom>/wasm-r3/third_party/wizard-engine/bin/wizeng.x86-64-linux -mode=int {WASM}'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    if PRINT: print(result)
    if result.returncode != 0 and result.returncode != 124: # error but not timeout
        return True
    else:
        return False

def correct_on_other():
    command = f'timeout 20s wizard-ccf0c56 -mode=jit {WASM}'
    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True,
    )
    if PRINT: print(result)
    if result.returncode == 0:
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
