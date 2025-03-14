#!/usr/bin/env python3

import os
import sys
import subprocess
if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]
PRINT = os.getenv('PRINT', 'False').lower() in ('true', '1', 't')

# commit bc135ad41605652df1818adb55b6eb73c7664c03 (HEAD -> titzer, upstream/master)
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Thu Mar 13 18:49:04 2025 -0400

#     [spc] Fix register overwrite bug in call_indirect (#345)

# commit f8ebda11fb99f05fbea8d6e7c85e38f5b388f5f1
# Author: evilg <evgilber@andrew.cmu.edu>
# Date:   Thu Mar 13 16:32:53 2025 -0400

#     Configure trampoline pages via fast-int tuning parameter (#344)


def wrong_on_target():
    command = f'timeout 10s wizard-563da52 -mode=spc {WASM}'
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
    command = f'timeout 20s wizard-be2b145 -mode=spc {WASM}'
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
