#!/usr/bin/env python3

import os
import sys
import subprocess
if len(sys.argv) != 2:
    print("Usage: oracle.py <WASM_FILE>")
    sys.exit(1)

WASM = sys.argv[1]
PRINT = os.getenv('PRINT', 'False').lower() in ('true', '1', 't')

# commit 6d2b05742997441fd4ac01d1cd18d71046cec703 (HEAD)
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Thu Jan 18 04:24:14 2024 -0500
#     [fast-int] Set four-byte sidetable entry by default

# commit 92a3330776928f0f1a39efe5bb83be67cb8cc0ba
# Merge: f8721590 83416e71
# Author: Ben L. Titzer <ben.titzer@gmail.com>
# Date:   Thu Jan 18 00:19:35 2024 +0000
#     [v3i/simd]: Minor update for the V3Interpreter (#150 from haoyu-zc/cleanup3)

# relevant code: setting fourByteSidetable off makes the control flow diverge

# // ELSE, (legal) CATCH, (legacy) CATCH_ALL: unconditional ctl xfer without stack copying
# bindHandlerNoAlign(Opcode.CATCH);
# bindHandlerNoAlign(Opcode.CATCH_ALL);
# bindHandlerNoAlign(Opcode.ELSE);
# asm.bind(ctl_xfer_nostack);
# if (FastIntTuning.fourByteSidetable) { // load and sign-extend a 4-byte pc delta
# 	asm.movd_r_m(r_tmp0, r_stp.plus(Sidetable_BrEntry.pc_delta.offset));
# 	asm.q.shl_r_i(r_tmp0, 32);
# 	asm.q.sar_r_i(r_tmp0, 32);
# } else {
# 	asm.movwsx_r_m(r_tmp0, r_stp.plus(Sidetable_BrEntry.pc_delta.offset));
# }
# asm.q.lea(r_ip, r_ip.plusR(r_tmp0, 1, -1)); // adjust ip
# if (FastIntTuning.fourByteSidetable) { // load and sign-extend a 4-byte STP delta
# 	asm.movwsx_r_m(r_tmp1, r_stp.plus(Sidetable_BrEntry.stp_delta.offset));
# 	asm.q.shl_r_i(r_tmp1, 32);
# 	asm.q.sar_r_i(r_tmp1, 32);
# } else {
# 	asm.movwsx_r_m(r_tmp1, r_stp.plus(Sidetable_BrEntry.stp_delta.offset));
# }
# asm.q.lea(r_stp, r_stp.plusR(r_tmp1, 4, 0)); // adjust stp XXX: preshift?
# endHandler();


def wrong_on_target():
    command = f'timeout 10s wizard-92a3330 -mode=int {WASM}'
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
    command = f'timeout 20s wizard-6d2b057 -mode=int {WASM}'
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
