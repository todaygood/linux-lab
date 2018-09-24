#!/bin/bash

for CPU in $( ls /sys/devices/system/cpu/cpu[0-9]* -d | sort); do
    echo 1 > $CPU/online;
done

