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

# Get OS distribution  from /etc/os-release.
# Filtered by ID, get  second tab after  equal sign using awk. Get rid of quotes using tr.
OS=$( cat /etc/os-release|grep -iE '^ID='| awk -F '=' '{print $2}'| tr -d '"' )

# For each software in input array install soft
for soft in "${input[@]}"
do
    # Use different commands depend on OS distribution using case operator and possible cases.
    # If neither ubuntu nor centos found, shows information message.
        case $OS in
        ubuntu)
            sudo apt -y install $soft
            ;;

        centos)
            sudo yum -y install $soft
            ;;

       *)  # This message will be shown if OS release do not match ubuntu or centos
           echo  "Sorry. Cannot define OS distribution. Cannot install soft on this host."
           ;;
    esac
done
