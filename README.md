# Wasm-R3: Record-Reduce-Replay for Realistic and Standalone  WebAssembly Benchmarks

Wasm-R3 is a record and replay framework that enables generation of standalone WebAssembly Benchmarks.

## Building the tool

We recommend you consult the [wasm-r3.yml](.github/workflows/wasm-r3.yml) workflow file to see the most up-to-date way to build and run the tool.

Pre-built docker images are also provided at [doehyunbaek1/wasm-r3](https://hub.docker.com/repository/docker/doehyunbaek1/wasm-r3/), but they are not always updated following the main branch.

As one of the authors regularly run Wasm-R3 on his Arm Mac machine, we are confident Wasm-R3 works well across Linux and Mac.

If you have any problems, please post Github Issue.

## Running
```
npm start <url>
```
- `<url>`: The url of the web app you want to record. Make sure it acutally uses wasm.

The command will start the recording. To stop the recording type any key into the terminal and press enter. The benchmark will be saved to disk.

## Testing 
```
npm test <category>
```
There are three categories of tests:
- `core`: These tests the core functionality of Wasm-R3. These tests are basically unit tests.
- `proxy`: These tests mainly exercise integration of core Wasm-R3 functionality in the web environments.
- `online`: These tests run on real world online web applications in order to confirm which websites are currently supported by Wasm-R3.

The faithfulness of Wasm-R3 is tested by comparing the trace generated during record with the trace generated during replay. The results of the testcases will be generated in the corresponding folders. Interesting files are the `report.txt` which contains information why a testcase failed. Also the trace for the record and the replay phase gets saved in `.r3` files.

## Resources

A 15-mintue [talk](https://youtu.be/2VCQBSy9sOg?si=rfRXaP6OT9iPT3Mi) given by one of the authors at Wasm Research Day 2024 is publicly available.
You can find a brief discussion of the motivation, approach, and evaluation of Wasm-R3.

A 10-minute [demo](https://youtu.be/2VCQBSy9sOg?si=loWLRALA5G9-wiEW&t=867) performed by one of the authors at Wasm Research Day 2024 is publicly available.

You can find a usage walkthorugh of Wasm-R3 and a sneak peak into its inner workings.

## Citation

Please refer to Wasm-R3 via our OOPSLA'24 paper:

```
@inproceedings{Baek2024Wasm-R3,
  title = {Wasm-R3: Record-Reduce-Replay for Realistic and Standalone WebAssembly Benchmarks},
  author = {Baek, Doehyun and Getz, Jakob and Sim, Yusung and Lehmann, Daniel and Titzer, Ben and Ryu, Sukyoung and Pradel, Michael},
  year = {2024},
  booktitle = {Proceedings of the ACM on Programming Languages: Object-Oriented Programming, Systems, Languages \& Applications},
  series = {OOPSLA '24},
}
```
