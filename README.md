# Wasm-R3

This folder contains the source code for the Wasm-R3 tool.

## Building

When first cloning the repository you want to install all dependencies. From the root of this repository run: 
```
npm install
```
To build Wasm-R3 with all its dependencies (specifically `Wasabi` and the `playwright chromium browser`) run:
```
npm run build-full
```
If you built and installed all the dependencies already and you make some changes to the Wasm-R3 source code only it is enough to run:
```
npm run build
```

## Running
```
npm start <url> <benchmark>
```
- `<url>`: The url of the web app you want to record. Make sure it acutally uses wasm.
- `<benchmark>`: Path to where the benchmark should be saved

The command will start the recording. To stop the recording type `Stop` into the terminal and press enter. The benchmark will be saved to disk.

## Testing
```
npm run test
```
There are three categories of tests:
- `node`: These tests the basic functionality of the tracer and replay generator. These tests are basically unit tests
- `offline`: These tests run Wasm-R3 on web applications that get hosted locally to test the (almost) end to end functionality.
- `online`: These tests run on real world online web applications in order to confirm which websites are currently supported by Wasm-R3.

To test only certain categories just provide the specific categories you want to test as an argument to the test command.

The faithfulness of Wasm-R3 is tested by comparing the trace generated during record with the trace generated during replay. The results of the testcases will be generated in the corresponding folders. Interesting files are the `report.txt` which contains information why a testcase failed. Also the trace for the record and the replay phase gets saved in `.r3` files. In case of `offline` and `online` the record traces are found under `benchmark/*/trace.r3` and the replay trace is found under `test-benchmark/*/trace.r3`
> NOTE: as additional faithfulness check we can also compare the **callgraph** generated during record to the **callgraph** generated during replay. Documentation incoming as soon as there is a stabel api for this.

### Adding testcases

Tests are located under `./tests`. There is one folder for each category which themselves contain a folder for each testcase. To write a new test, just copy one of the folders of the corresponding categories.
- To write a new `node` you need to provide a wasm module as a `.wat` file, and host code as a `.js` file, thats all that is needed. See the other tests on how to write your own tests.
- To write a new `offline` test you need to provide your own web application in a subfolder called `website` Then you also need a `.js` file in which you will automate user interactions on that website. See the already contained tests in order to see how to do that.
- To write a new `online` test you just need the automation `.js` file which is written in the same way as the `offline` `.js` files

## Internal APIs

Here is some minimal documentation of the internal APIs. Since Wasm-R3 is active under development these apis are subject to change. The most up to date documentation is always the source code. Very helpful as additional documentation are als the **typescript types**.

### Analyser

Wasm-R3 allwos you to run arbitrary Wasabi analysis on websites. To run your own analysis you need to use the `Analyser` class:
```typescript
const analysis = new Analyser('path/to/wasabi-analysis.js', options?)
const page = analysis.start('https://url-to-website.com', options?)
// perform what ever you want with the playwright `page` object
const result = analysis.stop()
```
> NOTE: `options` are unstable so there is no documentation provided just yet.

### Analysis

Your own custom analysis has to be provided as `.js` file. This file needs to define a class `Analysis`. The constructor takes as argument the `Wasabi` object. On this object you can define your analysis in `Wasabi.analysis` (Refer to the Wasabi documentation on how to do that). The class needs to additionally define the method `getResult` which shall return the result of the analysis as a single *serializable* object. (Check out for example `tracer.ts` to see how a analysis is defined)