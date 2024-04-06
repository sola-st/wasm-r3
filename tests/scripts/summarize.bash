#!/bin/bash

echo "benchmark,instr:static_total,instr:static_replay,instrs:dynamic_total,instrs:dynamic_replay,ticks:total,ticks:replay"

DATA_DIR=${DATA_DIR:=data}

while [ $# -gt 0 ]; do
    b=$1
    shift

    b=${b/-replay.wasm/}
    b=${b/-icount.csv/}
    b=${b/-fprofile.csv/}
    
    icount_file="${ICOUNT_FILE:-$DATA_DIR/$b-icount.csv}"
    ticks_file="${TICKS_FILE:-$DATA_DIR/$b-fprofile.csv}"
    
    if [ -f ${icount_file} ]; then
        static_total=$(awk -F "\"*,\"*" '{total += $2} END{print total}' ${icount_file})
        dynamic_total=$(awk -F "\"*,\"*" '{total += $3} END{print total}' ${icount_file})

        static_replay=$(grep \"r3\  ${icount_file} | awk -F "\"*,\"*" '{total += $2} END{print total}')
        dynamic_replay=$(grep \"r3\  ${icount_file} | awk -F "\"*,\"*" '{total += $3} END{print total}')
    else
        static_total="error"
        dynamic_total="error"
        static_replay="error"
        dynamic_replay="error"
    fi

    if [ -f ${ticks_file} ]; then
        ticks_total=$(grep main:time_cycles ${ticks_file} | awk '{print $3}')
        ticks_replay=$(grep \"r3\  ${ticks_file} | awk -F "\"*,\"*" '{total += $3} END{print total}')
    else
        ticks_total="error"
        ticks_replay="error"
    fi
    
    echo $b,$static_total,$static_replay,$dynamic_total,$dynamic_replay,$ticks_total,$ticks_replay

done
