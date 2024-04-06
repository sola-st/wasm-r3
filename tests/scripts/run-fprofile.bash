#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: run-iprofile.bash <benchmark-replay.wasm> <wizeng command>"
    exit 1
fi

WASM=$1
BENCHMARK=${WASM/-replay.wasm/}
shift

DATA_DIR=${DATA_DIR:=data}
mkdir -p $DATA_DIR

DATA_FILE=${DATA_FILE:-${DATA_DIR}/${BENCHMARK}-fprofile.csv}

echo "Collecting function profiles for $BENCHMARK > $DATA_FILE"

exec "$@" --metrics "--monitors=fprofile{r3*}" -csv $WASM > $DATA_FILE
