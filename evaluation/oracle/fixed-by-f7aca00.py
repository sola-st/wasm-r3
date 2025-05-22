#!/usr/bin/env python3

import os
import sys
import subprocess
if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]
PRINT = os.getenv('PRINT', 'False').lower() in ('true', '1', 't')

# commit f7aca00375912c7bd64f32ebc46093552a159c19
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Thu Apr 6 22:57:37 2023 -0400

#     [jit] Revamp regalloc to allow aliasing

# commit d46ae4ff786fd9154e47756818018d33bcf82709 (HEAD)
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Wed Apr 5 17:03:07 2023 -0400

#     [x86-64] Clean up value stack in run()


def wrong_on_target():
    command = f'timeout 10s wizard-d46ae4f -mode=jit {WASM}'
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
    command = f'timeout 20s wizard-f7aca00 -mode=jit {WASM}'
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
