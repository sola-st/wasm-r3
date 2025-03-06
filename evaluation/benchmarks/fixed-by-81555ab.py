#!/usr/bin/env python3

import os
import sys
import subprocess
if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]
PRINT = os.getenv('PRINT', 'False').lower() in ('true', '1', 't')

# commit 81555ab864dddd78bb75ecccb23837ef6bf552d3
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Fri Apr 7 17:30:46 2023 -0400

#     [jit] Use asm.movq_r_l where possible

# commit 6e594e9d60406039e4e04b9a9cf921fde6dd58d9
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Fri Apr 7 11:57:28 2023 -0400

#     [test] Reduce execution time of test/regress/byte_{div,mod}_ex


def wrong_on_target():
    command = f'timeout 10s wizard-6e594e9 -mode=jit {WASM}'
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
    command = f'timeout 20s wizard-81555ab -mode=jit {WASM}'
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
