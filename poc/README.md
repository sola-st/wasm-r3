# Introduction

This directory contains Proof of Concept (PoC) code for using
[Wasabi](http://wasabi.software-lab.org/) instrumentation tool to record
traces of WASM interacting with host environment (JS).

# How to use

1. Target WASM app

Init and update the git submodules to pull the `tictactoe-game-wasm`. The
submodule targets [tictactoe
game](https://github.com/yusungsim/tictactoe-game-wasm) repo.

The `tictactoe-game-wasm` directory contains a WASM web app of tic-tac-toe game.
It's forked from [arwalokhandwala's
repo](https://github.com/arwalokhandwala/tictactoe-game-wasm).
The directory already contains the instrumented codes.


1. Instrumenting the WASM binary

  - Install Wasabi instrumentation tool from 
  [GitHub repo](https://github.com/danleh/wasabi) 

  - Instrument (i.e. follow the *Option B* usage instruction from the
  Wasabi GitHub repo) the main WASM binary, `tic_tac_toe.wasm`.
  (Current `tic_tac_toe.wasm` is already instrumented, so you don't
  need to instrument it again. The original, uninstrumented `tic_tac_toe.wasm` 
  is saved as `tic_tac_toe.wasm.orig`.)

  - Copy the generated WASM binary and JS code from `out/` directory.
  (i.e. do the command `cp out/* .`)

2. Write the high-level Wasabi instrumentation script.

  - Currently implemented instrumentation script is in `call-hook.js`.

3. Modify the main `html` file.

  - Add the `<script>` tag to load the Wasabi-generated JS script and
  the high-level instrumentation script.

  ```html
<script src="tic_tac_toe.js"></script>
<script src="tic_tac_toe.wasabi.js"></script>
<script src="call-hook.js"></script>
  ```   

