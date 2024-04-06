#!/bin/bash

echo "benchmark,static_total,dynamic_total,static_replay,dynamic_replay"

while [ $# -gt 0 ]; do

    b=$1
    shift
    
static_total=$(awk -F "\"*,\"*" '{total += $2} END{print total}' $b)
dynamic_total=$(awk -F "\"*,\"*" '{total += $3} END{print total}' $b)

static_replay=$(grep \"r3\  $b | awk -F "\"*,\"*" '{total += $2} END{print total}')
dynamic_replay=$(grep \"r3\  $b | awk -F "\"*,\"*" '{total += $3} END{print total}')

echo ${b/-icount.csv/},$static_total,$dynamic_total,$static_replay,$dynamic_replay

done
