#!/bin/bash

set -e
# Colours
BLACK=$'\e[0;30m'
WHITE=$'\e[0;37m'
BWHITE=$'\e[1;37m'
RED=$'\e[0;31m'
BLUE=$'\e[0;34m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
NC=$'\e[0m' # No Colour

cat $1 | jq -r '.lyrics.lines[]|[ .startTimeMs, .words] | @tsv' |
	while IFS=$'\t' read -r startTimeMs words; do
		echo "[$(date -d "1970-01-01 $(($startTimeMs / 1000)) seconds" +%M:%S).$(($startTimeMs - ($startTimeMs / 1000) * 1000))]$words"
	done
