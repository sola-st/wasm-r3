# Tracing

Instrumentation can be intrusive or non intrusive. One could also say invasive or non invasive [Open Tracing Tools: Overview and Critical Comparison](https://arxiv.org/pdf/2207.06875.pdf)

A trace format that could be used is [EPILOG Binary Trace-Data Format](https://juser.fz-juelich.de/record/37836/files/ib-2004-06.pdf) This always contains a timestamp


let { buffer, Wasabi } = instrument(module, options)

