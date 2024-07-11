import subprocess, json, os

# Portability experiment
print('RQ1-2: Portability Experiment')

r3_path = os.getenv('WASMR3_PATH', '/home/wasm-r3')
test_name = os.getenv('TEST_NAME')

with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'r') as f:  metrics = json.load(f)
def trace_match(metrics, testname): return metrics[testname]['summary']['trace_match']

def get_replay_wasm(testname, opt):
    regex = ''
    match opt:
        case 'noopt':
            regex = 'merge|split|custom|benchmark'
        case 'split':
            regex = 'noopt|merge|custom|benchmark'
        case 'merge':
            regex = 'noopt|split|custom|benchmark'
        case 'benchmark':
            regex = 'noopt|split|merge|custom'
        case _:
            exit('invalid op')
    find_command = f"find {r3_path}/tests/online/{testname} -name replay.wasm | grep -vE '{regex}'"
    find_result = subprocess.run(find_command, shell=True, capture_output=True, text=True)
    replay_path = find_result.stdout.strip()
    return replay_path

timeout = 180 # seconds
engine_kind = ['sm', 'sm-base', 'sm-opt', 'v8', 'v8-liftoff', 'v8-turbofan', 'jsc', 'jsc-int','jsc-bbq','jsc-omg', 'wizeng','wizeng-int','wizeng-jit','wizeng-dyn','wasmtime','wasmer','wasmer-base']
opt_kind = ['noopt', 'split', 'merge', 'benchmark']

def run_wish_you_were_fast(testname, engine, opt):
    try:
        global metrics
        replay_path = get_replay_wasm(testname, opt)
        command = f"RUNS=1 ENGINES={engine} compare-engines.bash {replay_path}"
        fixed_width = 30
        print(f'{testname:<{15}}{engine:<{15}}', end='')
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        if result.returncode != 0: 
            print("ERROR")
            raise Exception(result)
        else:
            runtime = float(result.stdout.split(":")[-1].strip())
            metrics[testname]['replay_metrics'][engine][opt] |= { 'runtime': runtime }
            print(runtime)
    except Exception as e:
        print(f"Failed to run {testname} with {opt}, error:\n{e}")
        metrics[testname]['replay_metrics'][engine][opt] = {}

testset = [test_name] if test_name else metrics.keys()
for testname in testset:
    if trace_match(metrics, testname):
        for engine in engine_kind:
            metrics[testname]['replay_metrics'][engine] = {}
            for opt in opt_kind:
                metrics[testname]['replay_metrics'][engine][opt] = {}
        for engine in engine_kind:
            for opt in ['benchmark']:
                run_wish_you_were_fast(testname, engine, opt)

with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'w') as f: json.dump(metrics, f, indent=4)