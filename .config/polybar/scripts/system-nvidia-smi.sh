#!/bin/sh

# source: https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/system-nvidia-smi

nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{ print ""$1"%"}'
