import subprocess, json, concurrent.futures, os

print("RQ4: Effectiveness of Replay Optimization")

REP_COUNT = int(os.getenv('REP_COUNT', 1))
r3_path = os.getenv('WASMR3_PATH', '/home/wasm-r3')
test_name = os.getenv('TEST_NAME')

with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'r') as f:  metrics = json.load(f)
def trace_match(metrics, testname): return metrics[testname]['summary']['trace_match']
timeout = 180 # seconds
engine_kind = ['sm', 'sm-base', 'sm-opt', 'v8', 'v8-liftoff', 'v8-turbofan', 'jsc', 'jsc-int','jsc-bbq','jsc-omg', 'wizeng','wizeng-int','wizeng-jit','wizeng-dyn','wasmtime','wasmer','wasmer-base']
opt_kind = ['noopt', 'split', 'merge', 'benchmark']

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

def run_wizard(testname, engine, opt, i):
    try: 
        replay_path = get_replay_wasm(testname, opt)
        command = f"timeout {timeout}s  wizeng.x86-64-linux --metrics {replay_path}"
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        if result.returncode != 0: raise Exception(result.args)
        _, profile = result.stdout.split("pregen:time_us")
        profile = 'pregen:time_us' + profile
        return [testname, engine, opt, i, {line.rsplit(":", 1)[0].strip(): line.rsplit(":", 1)[1].strip().replace("μs", "").strip() for line in profile.split("\n") if line}]
    except Exception as e:
        # Known case that doesn't work
        if testname == 'funky-kart' and opt == 'noopt':
            return
        print(f"Failed to run {testname} with {opt}, engine: {engine}")
        print(e)

testset = [test_name] if test_name else metrics.keys()
results = []
for testname in testset:
    if trace_match(metrics, testname):
        for opt in opt_kind:
            for i in range(REP_COUNT):
                print(f"{testname:<{15}}{opt:<{15}}", end='')
                result = run_wizard(testname, 'wizeng-int', opt, i)
                testname, engine, opt, i, metric = result
                print('SUCCESS')
                results.append(result)

for result in results:
    if result is None: continue
    testname, engine, opt, i, metric = result
    if not metrics[testname]['replay_metrics'].get(engine): metrics[testname]['replay_metrics'][engine] = {}
    if not isinstance(metrics[testname]['replay_metrics'][engine].get(opt), list): metrics[testname]['replay_metrics'][engine][opt] = []
    metrics[testname]['replay_metrics'][engine][opt].append(metric)

with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'w') as f: json.dump(metrics, f, indent=4)