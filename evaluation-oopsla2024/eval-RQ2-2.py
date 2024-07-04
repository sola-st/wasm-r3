import subprocess, csv, json, os

print("RQ2-2: Replay Characteristics Experiment")
print("running wizard with icount and fprofile monitor")

r3_path = os.getenv('WASMR3_PATH', '/home/wasm-r3')
 

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

path1 = get_replay_wasm('game-of-life', 'benchmark')
path2 = f"{r3_path}/tests/online/game-of-life/benchmark/bin_0/replay.wasm"

def extract_summarize(output):
    lines = output.strip().split('\n')
    data_line = lines[-1]
    data_parts = data_line.split(',')
    return [int(float(part)) for part in data_parts[1:]]

test_input_3 = """
benchmark,instr:static_total,instr:static_replay,instrs:dynamic_total,instrs:dynamic_replay,ticks:total,ticks:replay
/home/don/wasm-r3/tests/online/hydro/benchmark/bin_0/replay.wasm,344760,191,27138,59,228486,8934
"""
test_input_4 = """
benchmark,instr:static_total,instr:static_replay,instrs:dynamic_total,instrs:dynamic_replay,ticks:total,ticks:replay
/home/don/wasm-r3/tests/online/multiplyDouble/benchmark/bin_0/replay.wasm,256244,238157,2.47543e+09,2100082177,9918500160,8.88911e+09
"""
assert(extract_summarize(test_input_3) == [344760, 191, 27138, 59, 228486, 8934])
assert(extract_summarize(test_input_4) == [256244, 238157, 2475430000, 2100082177, 9918500160, 8889110000])

with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'r') as f:  metrics = json.load(f)
def trace_match(metrics, testname): return metrics[testname]['summary']['trace_match']

# Replay characteristic experiment
timeout = 180 # seconds
wizard_engine_kind = ['wizeng-int']
wizard_opt_kind = ['benchmark']

# this lies as it actually collects from jit mode not int
def run_icount(testname, engine, opt):
    data_path = f"{r3_path}/evaluation-oopsla2024/data/{testname}-icount.csv"
    replay_path = get_replay_wasm(testname, opt)
    cmd = f'. ~/.bashrc && DATA_FILE={data_path} {r3_path}/tests/scripts/run-icount.bash {replay_path} wizeng.x86-64-linux'
    try:        
        result = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE, text=True)
        with open(data_path, 'r') as f: 
            output = csv.DictReader(f)
            output_dict = {row['Function']: {'static': row['static'], 'dynamic': row['dynamic']} for row in output}
            return output_dict
    except Exception as e:
        print(f"Failed to run:")
        print(cmd)
        return {}
    
def run_fprofile(testname, engine, opt):
    data_path = f"{r3_path}/evaluation-oopsla2024/data/{testname}-fprofile.csv"
    replay_path = get_replay_wasm(testname, opt)
    cmd = f'. ~/.bashrc && DATA_FILE={data_path} {r3_path}/tests/scripts/run-fprofile.bash {replay_path} wizeng.x86-64-linux'
    try:
        result = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE, text=True)
        with open(data_path, 'r') as f: 
            output = csv.DictReader(f)
            output_dict = {}
            summary_dict = {}
            for row in output:
                if row['Function'].startswith('r3'):
                    output_dict[row['Function']] = {'count': row['count'], 'cycles': row['cycles'], 'percent': row['percent']}
                else:
                    key, value = row['Function'].rsplit(':', 1)
                    summary_dict[key.strip()] = value.strip()
            return output_dict, summary_dict
    except Exception as e:
        print(f"Failed to run:")
        print(cmd)
        return {}, {}
    
def run_summarize(testname, engine, opt):
    icount_path = f"{r3_path}/evaluation-oopsla2024/data/{testname}-icount.csv"
    ticks_path = f"{r3_path}/evaluation-oopsla2024/data/{testname}-fprofile.csv"
    replay_path = get_replay_wasm(testname, opt)
    cmd = f'. ~/.bashrc && ICOUNT_FILE={icount_path} TICKS_FILE={ticks_path} {r3_path}/tests/scripts/summarize.bash {replay_path}'
    try:
        result = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE, text=True)
        instr_static_total, instr_static_replay, instrs_dynamic_total, instr_dynamic_replay, ticks_total, ticks_replay = extract_summarize(result.stdout)
        return {
            'instr_static_total': instr_static_total,
            'instr_static_replay': instr_static_replay,
            'instrs_dynamic_total': instrs_dynamic_total,
            'instr_dynamic_replay': instr_dynamic_replay,
            'ticks_total': ticks_total,
            'ticks_replay': ticks_replay,
        }
    except Exception as e:
        print(f"Failed to run:")
        print(cmd)
        return {}

testset = metrics
results = []
for testname in testset:
    if trace_match(metrics, testname): 
        for engine in wizard_engine_kind:
            for opt in wizard_opt_kind:
                if not metrics[testname]['replay_metrics'].get(engine): metrics[testname]['replay_metrics'][engine] = {}
                if not metrics[testname]['replay_metrics'][engine].get(opt): metrics[testname]['replay_metrics'][engine][opt] = {}
                os.makedirs(f'{r3_path}/evaluation-oopsla2024/data', exist_ok=True)
                if not metrics[testname].get('ticks'): metrics[testname]['ticks'] = []
                for i in range(10):
                    run_icount(testname, engine, opt) 
                    run_fprofile(testname, engine, opt) 
                    metrics[testname]['ticks'].append({**run_summarize(testname, engine, opt)})

with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'w') as f: json.dump(metrics, f, indent=4)