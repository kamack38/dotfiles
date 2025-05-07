#!/bin/bash

USAGE="󰍹  $(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)%"
MEMORY_USAGE="$(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader | sed 's#,# /#')"

if [[ "$count" != "0" ]]; then
	echo '{"text": "'$USAGE'","tooltip":"'${MEMORY_USAGE}'"}'
fi
