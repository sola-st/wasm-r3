# RQ 2-2
import tabulate, scipy.stats, json, numpy as np
import matplotlib.pyplot as plt
import argparse

parser = argparse.ArgumentParser(description='Generate a performance record graph.')
parser.add_argument('output_file', help='The path to the output PDF file.')
args = parser.parse_args()


with open('metrics.json', 'r') as f: metrics = json.load(f)
def trace_match(metrics, testname): return metrics[testname]['summary']['trace_match']

data = {}
for testname in metrics:
    if not trace_match(metrics, testname): continue
    try: 
        data[testname] = {}
        data[testname]['instrs_replay_portion'] = metrics[testname]['summary']['instr_dynamic_replay'] / metrics[testname]['summary']['instrs_dynamic_total']
        data[testname]['ticks_replay_portion'] = metrics[testname]['summary']['ticks_replay'] / metrics[testname]['summary']['ticks_total']
    except Exception as e:
        del data[testname]
        print(f"Error in {testname}: {e}")

# Plot the portions
instrs_replay_portions = [[testname, data[testname]['instrs_replay_portion']] for testname in data]
instrs_replay_portions.sort(key=lambda x: x[1], reverse=True)
ticks_replay_portions = [[testname, data[testname]['ticks_replay_portion']] for testname in data]
ticks_replay_portions.sort(key=lambda x: x[1], reverse=True)

# Plot the ticks portions
# Plot the instrs portions
# TODO: do the same with instructions
# plt.figure(figsize=(10, 6))
# plt.bar([a for a, b in instrs_replay_portions], [1]*len(instrs_replay_portions), label='Total', color='blue')
# plt.bar([a for a, b in instrs_replay_portions], [b for a, b in instrs_replay_portions], label='Replay', color='red')
# plt.xlabel('Test Name')
# plt.xticks(rotation=90)
# plt.ylabel('Portion')
# plt.title('Instrs Replay Portion')
# plt.legend()
# plt.show()
# # Plot the instrs portions
# Plot the instrs portions
plt.figure(figsize=(10, 3))

plt.xlim(-0.5, 27.5)
plt.ylim(0, 1)
#plt.plot([-0.5, 26.5], [0.2, 0.2], color='grey', alpha=0.7, linewidth=0.4)
#plt.plot([-0.5, 26.5], [0.4, 0.4], color='grey', alpha=0.7, linewidth=0.4)
#plt.plot([-0.5, 26.5], [0.6, 0.6], color='grey', alpha=0.7, linewidth=0.4)
#plt.plot([-0.5, 26.5], [0.8, 0.8], color='grey', alpha=0.7, linewidth=0.4)
plt.bar([a for a, b in ticks_replay_portions], [1]*len(ticks_replay_portions),
        label='Original', color='lightgrey')
plt.bar([a for a, b in ticks_replay_portions], [b for a, b in ticks_replay_portions], label='Replay', color='gray')
#plt.xlabel('Test Name')
plt.xticks(rotation=90)
plt.ylabel('Portion')
plt.legend()
plt.savefig(args.output_file, bbox_inches='tight')
