#!/usr/bin/env bash
# @vicinae.schemaVersion 1
# @vicinae.title Run with prime-run
# @vicinae.mode silent
# @vicinae.icon /usr/share/icons/.Fluent-base/scalable/apps/nvidia.svg
# @vicinae.argument1 { "type": "text", "placeholder": "command" }

export LIBVA_DRIVER_NAME=nvidia
setsid bash -c "prime-run $1" >/dev/null 2>&1 &
