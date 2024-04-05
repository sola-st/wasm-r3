import tabulate, scipy.stats, json, numpy as np
import matplotlib.pyplot as plt
import argparse

# Parse command-line arguments
parser = argparse.ArgumentParser(description='Generate a performance record graph.')
parser.add_argument('output_file', help='The path to the output PDF file.')
args = parser.parse_args()

# RQ 2-1

with open('metrics.json', 'r') as f: 
    metrics = json.load(f)
    del metrics['parquet'] # record fails
def trace_match(metrics, testname):return metrics[testname]['summary']['trace_match']

def get_cycles_slowdown(testname):
    original_cycles = []
    record_cycles = []
    for i in range(10):
        cycles_sum = sum(metrics[testname]['record_metrics']['original'][i]['cycles']) 
        if not cycles_sum > 0:
            print(f"flaky result for original {testname}, {i}th, skipping in geomean calculation")
            continue
        original_cycles.append(cycles_sum)
    for i in range(10):
        cycles_sum = sum(metrics[testname]['record_metrics']['instrumented'][i]['cycles']) 
        if not cycles_sum > 0:
            print(f"flaky result for record {testname}, {i}th, skipping in geomean calculation")
            continue
        record_cycles.append(cycles_sum)
    return scipy.stats.gmean(record_cycles) / scipy.stats.gmean(original_cycles)

table = sorted([(testname, get_cycles_slowdown(testname)) for testname in metrics if trace_match(metrics, testname)], key=lambda x: x[1], reverse=True)
print(tabulate.tabulate(table, tablefmt="latex"))

plt.figure()
testname_gmean_pairs = [(row[0], row[-1]) for row in table]
testname_gmean_pairs.sort(key=lambda pair: pair[1], reverse=True)
gmean_values = [pair[1] for pair in testname_gmean_pairs]
test_names = [pair[0] for pair in testname_gmean_pairs]
plt.figure(figsize=(10,4))
plt.tight_layout()
plt.xlim(-0.5, 26.5)
plt.bar(test_names, gmean_values, label='Geometric Mean', color='gray')
plt.xticks(rotation=90)
plt.yticks(list(range(int(min(gmean_values)), int(max(gmean_values)) + 1, 4)) + [1])
plt.ylabel('CPU Cycles Slowdown')
plt.plot([-1, 29], [1, 1], linestyle='dashed', color='black')
plt.savefig(args.output_file, bbox_inches='tight')
