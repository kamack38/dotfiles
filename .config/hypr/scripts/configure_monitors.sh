#!/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-~/.config}"

if hyprctl monitors -j | jq -e '.[] | select(.name == "DP-1") | length > 0'; then
	waybar -c "$XDG_CONFIG_HOME/waybar/config.jsonc"
else
	waybar -c "$XDG_CONFIG_HOME/waybar/laptop-config.jsonc"

	# Leave empty space for the bar
	hyprctl keyword workspace w[t1] m[0], gapsout:5 0 0 0
	hyprctl keyword workspace f[1] m[0], gapsout:5 0 0 0
fi
