#!/bin/bash
perf stat -C 0-15 -e 'cpu_core/cpu-cycles/' -- $*
# /home/don/.cache/ms-playwright/chromium-1105/chrome-linux/chrome --renderer-process-limit=1 --no-sandbox --renderer-cmd-prefix='bash ./a.sh'