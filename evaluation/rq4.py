import time, subprocess, os, json
from sanity_check import extract_code_bytes
from evaluation import sh

with open("metrics.json", "r") as f:
    metrics = json.load(f)

WASMR3_PATH = os.getenv("WASMR3_PATH", "~/wasm-r3")
metrics['rq4'] = {}

paths = sh(f'ls -1 {WASMR3_PATH}/benchmarks/tcas').splitlines()
for path in paths:
    if not path.startswith("tcas") or 'sliced' in path:
        continue
    extracted_path = path.replace(".wasm", ".sliced.wasm")
    metrics['rq4'][path] = {}
    command = f"BENCHMARK_PATH=~/wasm-r3/benchmarks/tcas python {WASMR3_PATH}/evaluation/run_reduction_tool.py wasm-slice {WASMR3_PATH}/benchmarks/tcas/oracle.py {WASMR3_PATH}/benchmarks/tcas/{path}"
    start_time = time.time()
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    end_time = time.time()
    elapsed = end_time - start_time
    input_code_size = extract_code_bytes(sh(f'wasm-tools objdump {WASMR3_PATH}/benchmarks/tcas/{path}'))
    extracted_code_size = extract_code_bytes(sh(f'wasm-tools objdump {WASMR3_PATH}/benchmarks/tcas/{extracted_path}'))
    metrics['rq4'][path]['wasm-slice-time'] = elapsed
    metrics['rq4'][path]['original-size-code'] = input_code_size
    metrics['rq4'][path]['wasm-slice-size-code'] = extracted_code_size
with open("metrics.json", "w") as f:
    json.dump(metrics, f, indent=4)