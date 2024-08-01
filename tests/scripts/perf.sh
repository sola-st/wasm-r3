#!/bin/bash
perf stat -C 0-15 -e 'cpu-cycles' -- $*
