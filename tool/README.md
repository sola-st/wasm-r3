# Wasm-R3

This folder contains the source code for the Wasm-R3 tool. Below there is a rough overview on how the tool works. We might adjust it during development.

### Artchitecture
The tool consists out of multiple components

1. **recorder**: This component will take an WebAssembly binary as an input, instrument it with [wasabi](https://github.com/danleh/wasabi) and add the functionality that a [trace](trace-spec.md) gets collected during the execution of that binary. The output of this component [trace](trace-spec.md) optionally in textual representation. Subcommands:
    * **instrument**: instrument the binary with wasabi and adds the recorder logic
    * **record**: fires up the instrumented application and actually records 

2. **replay-generator**: This component will take the [trace](trace-spec.md) in textual representation as input and generate a replay binary consisting of a WebAssembly binary and Javascript gluecode.

3. **packager**: This component will take the replay binary and the original application as an input and package it into an executable benchmark

4. **r3-cli**: This component provides an user interface to integrate the other components into one unified interface. That is easy and consistent to use by a user.