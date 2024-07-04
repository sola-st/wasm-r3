import subprocess, time, json, os, re

REP_COUNT = int(os.getenv('REP_COUNT', 1))
r3_path = os.getenv('WASMR3_PATH', '/home/wasm-r3')
with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'r') as f: metrics = json.load(f)
def trace_match(metrics, testname): return metrics[testname]['summary']['trace_match']

# Record overhead experiment
timeout = 120 # seconds
chromium_path = os.getenv('CHROME_PATH', '/root/.cache/ms-playwright/chromium-1105/chrome-linux/chrome')
perf_sh_path = f'{r3_path}/tests/perf.sh'
CDP_PORT = os.getenv('CDP_PORT', 8080)
os.environ['CDP_PORT'] = str(CDP_PORT)
option_to_cmd = {
    'original': '--noRecord',
    'instrumented': '',
}

def extract_samples_and_mean(output):
    match = re.search(r"recorded (\d+) samples, mean = ([\d\.]+)", output)
    samples = int(match.group(1))
    mean = float(match.group(2))
    return [samples, mean]
def extract_cycle_counts(output):
    pattern = r"(\d+(?:,\d+)*)\s+cpu-cycles"
    matches = re.findall(pattern, output)
    cycle_counts = [int(match.replace(',', '')) for match in matches]
    return cycle_counts
test_input = """
DevTools listening on ws://127.0.0.1:9966/devtools/browser/f72191be-fbd6-4fbd-b21f-2703612f1f13
 Performance counter stats for 'CPU(s) 0-15':
    40,125,664,880      cpu-cycles
       6.157604349 seconds time elapsed
 Performance counter stats for 'CPU(s) 0-15':
     2,702,581,574      cpu-cycles
       0.267278301 seconds time elapsed
"""
assert extract_cycle_counts(test_input) == [40125664880, 2702581574]
test_input_2 = """
================
Run online tests
================
WARNING: You need a working internet connection
WARNING: Tests depend on third party websites. If those websites changed since this testsuite was created, it might not work
fib  -Histogram: V8.ExecuteMicroSeconds recorded 581 samples, mean = 9993.9 (flags = 0x41)

581 9993.9
nvm
"""
assert extract_samples_and_mean(test_input_2) == [581, 9993.9]

def run_command(testname, option, i):
    try:
        subprocess.run(["killall", "-9", "chrome"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        chromium_cmd = f"{chromium_path} --headless --renderer-process-limit=1 --no-sandbox --remote-debugging-port={CDP_PORT} --js-flags='--slow-histograms' --renderer-cmd-prefix='bash {perf_sh_path}'"
        wasmr3_cmd = f"timeout {timeout}s npm test -- --evalRecord {option_to_cmd[option]} -t {testname}"
        output_path = f"{r3_path}/evaluation-oopsla2024/output/{testname}_{option}_{i}.txt"
        with open(output_path, 'w') as f: subprocess.Popen(chromium_cmd, shell=True, stdout=f , stderr=f)
        result = subprocess.run(wasmr3_cmd, shell=True, stdout=subprocess.PIPE, text=True)
        time.sleep(3)
        with open(output_path, 'r') as f: output = f.read()
        cycle_counts = extract_cycle_counts(output)
        return [testname, option, cycle_counts]
    except Exception as e:
        print(f"Failed to run {testname} with {option}, error: {e}")
        return [testname, option, -1, -1, -1]

os.makedirs(f'{r3_path}/evaluation-oopsla2024/output', exist_ok=True)
results = []
for testname in metrics:
    if trace_match(metrics, testname):
        for option in ['original', 'instrumented']:
            metrics[testname]['record_metrics'][option] = []
            for i in range(REP_COUNT):
                print(f"{testname:<{15}}{option:<{15}}", end='')
                testname, _, cycles = run_command(testname, option, i) 
                print(f'{sum(cycles)} cycles')
                metrics[testname]['record_metrics'][option].append({'cycles': cycles})

with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'w') as f: json.dump(metrics, f, indent=4)