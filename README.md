# Wasm-R3: Record and Replay for WebAssembly

This repository contains latest code for Wasm-R3, a record and replay technique for WebAssembly.

For the artifacts of the exact version used for the evaluation of the papers, please refer to the [Artifacts](#artifacts) section.

## Building the toolchain

We recommend you use [Visual Studio Code Dev Container](.devcontainer) to build Wasm-R3.

## Running the toolchain
```
npm start <url>
```
- `<url>`: The url of the web app you want to record. Make sure it acutally uses wasm.

The command will start the recording. To stop the recording type any key into the terminal and press enter. The benchmark will be saved to disk.

## Testing the toolchain
```
npm test <category>
```
There are three categories of tests:
- `core`: These tests the core functionality of Wasm-R3. These tests are basically unit tests.
- `proxy`: These tests mainly exercise integration of core Wasm-R3 functionality in the web environments.
- `online`: These tests run on real world online web applications in order to confirm which websites are currently supported by Wasm-R3.

The faithfulness of Wasm-R3 is tested by comparing the trace generated during record with the trace generated during replay. The results of the testcases will be generated in the corresponding folders. Interesting files are the `report.txt` which contains information why a testcase failed. Also the trace for the record and the replay phase gets saved in `.r3` files.

## Benchmarks

There are two benchmarks related to the Wasm-R3 toolchain.
These benchmarks are maintained in the separate repository [wasm-benchmarks](https://github.com/doehyunbaek/wasm-benchmarks).

To access wasm-r3-bench, introduced in the OOPSLA 2024 paper, please refer to the following directory:
- [wasm-r3-bench](https://github.com/doehyunbaek/wasm-benchmarks/tree/main/wasm-r3-bench) 

To access wasm-reduce-bench, introduced in the ASE 2025 paper, please refer to the following directory:
- [wasm-reduce-bench](https://github.com/doehyunbaek/wasm-benchmarks/tree/main/wasm-reduce-bench)

## Artifacts

There are two peer-reviwed papers and two Master's thesis related to the Wasm-R3 toolchain.
To access the artifacts of the exact version used for the evaluation of each paper or thesis, please refer to the following branch:
- [Wasm-R3: Record-Reduce-Replay for Realistic and Standalone WebAssembly Benchmarks (OOPSLA 2024)](https://dl.acm.org/doi/pdf/10.1145/3689787)
  - [OOPSLA_2024](https://github.com/sola-st/wasm-r3/tree/OOPSLA_2024)
- [Execution-Aware Program Reduction for WebAssembly via Record and Replay (ASE 2025)](https://www.arxiv.org/pdf/2506.07834)
  - [ASE_2025](https://github.com/sola-st/wasm-r3/tree/ASE_2025)
- [Wasm-R3: Creating Executable Benchmarks of WebAssembly Binaries via Record-Reduce-Replay (University of Stuttgart MS, 2024)](https://elib.uni-stuttgart.de/server/api/core/bitstreams/10b3c7e0-4947-4d23-b374-3c6354e446f3/content)
  - [JAKOB_MASTER](https://github.com/sola-st/wasm-r3/tree/JAKOB_MASTER)
- [Automated Construction and Reduction of WebAssembly Benchmarks (KAIST MS, 2025)](https://library.kaist.ac.kr/search/detail/view.do?bibCtrlNo=1122301&flag=dissertation)
  - [DOEHYUN_MASTER](https://github.com/sola-st/wasm-r3/tree/DOEHYUN_MASTER)

## Resources

For Wasm-R3, a 15-minute [talk](https://youtu.be/2VCQBSy9sOg?si=RSgkfvCCNWQCZnf9) at Wasm Research Day 2024 is publicly available.

For RR-Reduce, a 15-minute [talk rehearsal](https://youtu.be/ksClQmaOyBI?si=VDoHLmMd3R97y7jx) prepared for Wasm Research Day 2025 is publicly available.

A 10-minute [demo](https://youtu.be/2VCQBSy9sOg?si=loWLRALA5G9-wiEW&t=867) performed by one of the authors at Wasm Research Day 2024 is publicly available.
You can find a usage walkthorugh of Wasm-R3 and a sneak peak into its inner workings.

## Citation

To refer to Wasm-R3, please cite the following paper:

```
@article{Baek2024Wasm-R3,
  author       = {Doehyun Baek and Jakob Getz and Yusung Sim and Daniel Lehmann and Ben L. Titzer and Sukyoung Ryu and Michael Pradel},
  title        = {Wasm-R3: Record-Reduce-Replay for Realistic and Standalone WebAssembly Benchmarks},
  journal      = {Proc. {ACM} Program. Lang.},
  volume       = {8},
  number       = {{OOPSLA2}},
  pages        = {2156--2182},
  year         = {2024},
  url          = {https://doi.org/10.1145/3689787},
  doi          = {10.1145/3689787},
  timestamp    = {Sun, 19 Jan 2025 14:47:44 +0100},
  biburl       = {https://dblp.org/rec/journals/pacmpl/BaekGS0TRP24.bib},
  bibsource    = {dblp computer science bibliography, https://dblp.org}
}
```

To refer to RR-Reduce, please cite the following paper:

```
@inproceedings{Baek2025RR-Reduce,
  author       = {Doehyun Baek and Daniel Lehmann and Ben L. Titzer and Sukyoung Ryu and Michael Pradel},
  title        = {Execution-Aware Program Reduction for WebAssembly via Record and Replay},
  booktitle    = {Proceedings of the 39th {IEEE/ACM} International Conference on Automated Software Engineering, {ASE} 2025, Seoul, South Korea, November 16 - November 20, 2025},
  year         = {2025},
}
```