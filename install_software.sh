#!/bin/bash
#Array with software list
input=()

# Check stdin if we can get a soft from pipeline.
# If something exist get line-by-line and add to input array
if [ -p /dev/stdin ]; then
    while IFS= read line; do
        input+=("${line}")
    done
