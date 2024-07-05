import os, json, re, subprocess

r3_path = os.getenv('WASMR3_PATH', '/home/wasm-r3')

def assert_cover_all(expected_dirs):
    online_tests_path = os.path.join(r3_path, 'tests/online')
    actual_dirs = [name for name in os.listdir(online_tests_path) if os.path.isdir(os.path.join(online_tests_path, name))]
    try:
        assert set(actual_dirs) == set(expected_dirs)
    except AssertionError:
        missing_dirs = set(expected_dirs) - set(actual_dirs)
        extra_dirs = set(actual_dirs) - set(expected_dirs)
        print(f"Assertion failed: Missing directories: {missing_dirs}, Extra directories: {extra_dirs}")
        raise
def trace_match(metrics, testname):
    return metrics[testname]['summary']['trace_match']

# Setup evaluation suite

eval_set = ['fractals', 'parquet', 'ogv', 'factorial', 'gotemplate', 'sandspiel', 'hydro', 'hnset-bench', 'boa', 'livesplit', 'ffmpeg', 'takahirox', 'pathfinding', 'bullet', 'rustpython', 'timestretch', 'riconpacker', 'rguistyler', 'wheel', 'game-of-life', 'jsc', 'multiplyInt', 'fib', 'guiicons', 'funky-kart', 'playnox', 'jqkungfu', 'figma-startpage', 'sqlpractice', 'mandelbrot', 'pacalc', 'waforth', 'roslyn', 'lichess', 'rtexpacker', 'image-convolute', 'commanderkeen', 'onnxjs', 'rguilayout', 'rfxgen', 'rtexviewer', 'multiplyDouble', 'sqlgui']

skip_set = [
    'ogv' # record run is abnormal but not filtered out by test framework because it produces something.
]

# These are excluded as they don't appear in either Made with WebAssembly(https://madewithwebassembly.com/) or Awesome-Wasm(https://github.com/mbasso/awesome-wasm)
excluded_set = [
    "handy-tools",
    'heatmap',
    "kittygame",
    'visual6502remix',
    'noisereduction',
    'skeletal',
    'uarm',
    'virtualkc',
]

print('Evaluation set: ', len(eval_set))
# print('exclude: ', len(excluded_set))
assert_cover_all(eval_set + excluded_set)

testset = sorted(eval_set)
metrics = {testname: { 'summary': {}, 'record_metrics': {}, 'replay_metrics': {}} for testname in testset }

print('RQ1-1: Accuracy Experiment')

# Trace difference experiment
timeout = 180

def run_wasmr3(testname):
    if testname in skip_set: return [testname, False]
    command = f"timeout {timeout}s npm test -- -t {testname}"
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    isNormal = result.returncode == 0
    fixed_width = 30
    print(f'{testname:<{fixed_width}}', end='')
    print('SUCCESS' if isNormal else 'ERROR')
    return [testname, isNormal]

results = [run_wasmr3(testname) for testname in testset]
for testname, isNormal in results:
    metrics[testname]['summary']['trace_match'] = isNormal
    if isNormal:
        # get stats for RQ3
        with open(f"{r3_path}/tests/online/{testname}/benchmark/bin_0/stats.json", 'r') as f: stats = json.load(f)
        metrics[testname]['summary'] |= stats

with open(f'{r3_path}/evaluation-oopsla2024/metrics.json', 'w') as f: json.dump(metrics, f, indent=4)