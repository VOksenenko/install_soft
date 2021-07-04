#!/bin/bash
#Array with software list
input=()

# Check stdin if we can get a soft from pipeline.
# If something exist get line-by-line and add to input array
if [ -p /dev/stdin ]; then
    while IFS= read line; do
        input+=("${line}")
    done


# If nothing from stdin, then we check arguments for software.
# If no argument provided we tell user about it.
elif [ $# -eq 0 ]; then
    echo "Provide software list as argument"
# In the end we get soft from file line-by-line
else
    inputfile=$1
    while IFS= read -r line; do
        input+=("${line}")
    done < "$inputfile"
fi
