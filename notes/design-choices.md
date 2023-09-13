# Design choices

This document dicusses possible design choices on implemenation of the
WASM-R3 tool.

# Format of Replay Binary

## Possible choices

- JS script
- Another WASM binary
- WASM binary + JS glue code (for linking import/exports)

## Preferred choice

- Another WASM binary

## Considered factors

- Efficiency: JS induces significant overhead during execution of original WASM
  binary

- WASM supported features: WASM 2.0 supports table access instructions
  (`table.get`, `table.set`). Side effects to stack / memory / table can fully
  represented by WASM binary.


# Number/correspondance of Replay Binaries

## Possible choices

- 1 replay binary per app
- 1 replay binary per WASM binary

## Preferred choice

- 1 replay binary per WASM binary

## Considered factors

- Consider a web app with multiple WASM binaries. 
  In a point of view of each WASM binary, the other WASM binaries can also be 
  thought as an *external host environment*, so all interaction between a single 
  WASM binary and (other WASM binaries + JS host) can be represented in a single
  trace sequence.

- Simplicity: Wasabi instruments 1 WASM binary at a time. So the pipeline of
  1 Wasabi instrumentation --> 1 instrumented WASM binary --> 1 WASM execution
  trace --> 1 replay binary is simple and reasonable.

- Compositionality: To replay a web app with multiple binaries, we can compose
  the replay binaries of each WASM binary and produce a whole-view replay of the
  web app. (The exact method to compose the single-WASM traces into whole-app
  trace is a TODO.)


# Timestamp

## Possible choices

- Record timestamp in each trace
- Do not record timestamp, soley depend on the order between traces

## Preferred choice

- Do not record timestamp, soley depend on the order between traces.

## Considered factors

- For purpose of replaying the behavior of the host environment's effect on the
  WASM runtime state, it is sufficient to only record the order of the traces
  and replaying them in same order.

- Compared to JS, where asynchronous timings of events can differ by
  executions, WASM long execution cannot be interfered from external host before
  the synchronous current execution is done.

- Combined with the above design choice, recording the order of traces for each
  WASM binary is enough to generate the correct replay binary of one WASM
  binary.


# Tracing Memory and Table effects

## Possible choices

- Dump the whole memory & table state for each call trace
- Log the load & store as a trace, use shadow memory to reduce redundant memory
  traces and produce correct replay

## Preferred choice

- Log the load & store as a trace, use shadow memory to reduce redundant memory
  traces and produce correct replay

## Considered factors

- Dumping can incur excess space overhead.

- Considering space & time locality, a lot of memory sections for each dump will
  have no relation with the trace, being unaffected. It is reasonable to only
  record the changes (i.e. write to memory) and replay them.

- Same strategy can be symmetrically applied to both memory and table. Memory -
  trace `load`/`store` instructions, table - trace `table.get`/`table.get`
  instructions.

- Although the dump-based approach can incur overhead, it can be used on tiny
  examples to make a testing oracle for the load-store-based approach.
