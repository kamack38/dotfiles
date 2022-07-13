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

printusage() {
	echo "Usage: $(basename $0) [-d, --delay <time in milliseconds>] [-o, --output <filename>] <filepath>" >&2
}

while getopts ":d:o:" flag; do
	case "${flag}" in
	d) delay=${OPTARG} ;;
	delay) delay=${OPTARG} ;;
	o) output=${OPTARG} ;;
	output) output=${OPTARG} ;;
	\?)
		printusage
		exit 1
		;;
	esac
done

filepath=${@:$OPTIND:1}

if [ -z ${filepath+x} ] || [ "$filepath" == "" ]; then
	echo "You must provide a filepath"
	printusage
	exit 1
fi

if [ -z ${delay+x} ]; then
	delay=0
fi

cat $filepath | jq -r '.lyrics.lines[]|[ .startTimeMs, .words] | @tsv' |
	while IFS=$'\t' read -r startTimeMs words; do
		startTimeMs=$(($startTimeMs + $delay))
		line="[$(date -d "1970-01-01 $(($startTimeMs / 1000)) seconds" +%M:%S).$(($startTimeMs - ($startTimeMs / 1000) * 1000))]$words"
		if [ -z ${output+x} ]; then
			echo "$line"
		else
			echo "$line" >>$output
		fi
	done
