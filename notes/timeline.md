# Timeline for Wasm-R3

- Until **November**:
    - Finish Wasabi implementation
    - Finish Wasm-R3 implementation
- **November**:
    - Finding real world programs that can be recorded and replayed with wasm-r3. (for inspiration on webscraping look into daniels wasmbench paper)
    - Find and implement a method for canning those programs for wasm-r3. Eg like this:
        - Give a url
        - Wasm-r3 instruments this website and displays it in the browser
        - User interacts with the website
        - User stops wasm-r3
        - wasm-r3 spits out the canned benchmark
    - Find evaluation Metrics (eg. Fidelity, Accuracy (see js benchmark paper))
    - Collect data
- **December**
    - Packaging of wasm-r3
    - Analysis of data
- **January**
    - Buffer
- **February**
    - Write thesis
    - Write paper?

# Technical contributions

High level:
- Automated construction of Benchmarks for webassembly (as like wasabi is also nothing else then another dynamic analysis framework through instrumentation for wasm)
- Conceptual Framework for record and replay techniques in general
Low level:
- Support record for serverside and clientside applications (arbitrary)
- Trace standart