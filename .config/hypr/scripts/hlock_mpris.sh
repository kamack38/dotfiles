#!/bin/env bash

THUMB=/tmp/hyde-mpris

fetch_thumb() {
	artUrl=$(playerctl metadata --format '{{mpris:artUrl}}')
	[[ "${artUrl}" = "$(cat "${THUMB}.inf")" ]] && return 0

	printf "%s\n" "$artUrl" >"${THUMB}.inf"

	curl -so "${THUMB}.png" "$artUrl"
	magick "${THUMB}.png" -quality 50 "${THUMB}.png"
	pkill -USR2 hyprlock
}

# if [ ! -f "${THUMB_RECTANGLE}" ]; then
#     magick -size 800x200 xc:none -fill black -draw "rectangle 0,0 800,200" -blur 0x3 "${THUMB_RECTANGLE}"
# fi

# Run fetch_thumb function in the background
{ playerctl metadata --format '{{title}}    {{artist}}' && fetch_thumb; } || { rm -f "${THUMB}*" && exit 1; } &
