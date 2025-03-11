#!/usr/bin/env python3

import os
import sys
import subprocess
if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]
PRINT = os.getenv('PRINT', 'False').lower() in ('true', '1', 't')

# commit 4e3e221de326f48ebb02d98f05ad72a4fa3bdad6
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Sun Feb 5 12:36:19 2023 -0500

#     [jit] Fix lazy compile for functions that have traps

# commit 253bd0243243acd7aa188fbb58a60f06145e927d
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Sun Feb 5 10:46:25 2023 -0500

#     [x86-64] Add trapHandlerOffsets to X86_64SpcCode

def wrong_on_target():
    command = f'timeout 10s wizard-253bd02 -mode=jit {WASM}'
    # command = f'timeout 10s /home/doehyunbaek/wasm-r3/third_party/wizard-engine/bin/wizeng.x86-64-linux -mode=int {WASM}'
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
    command = f'timeout 20s wizard-4e3e221 -mode=jit {WASM}'
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
