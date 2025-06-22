#!/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-~/.config}"

killall waybar
# Check if there are any other monitors than eDP-1
if hyprctl monitors -j | jq -e 'any(.[]; .name != "eDP-1")'; then
	waybar -c "$XDG_CONFIG_HOME/waybar/config.jsonc" &
	disown
else
	waybar -c "$XDG_CONFIG_HOME/waybar/laptop-config.jsonc" &
	disown

	# Leave empty space for the bar
	hyprctl keyword workspace w[t1] m[0], gapsout:5 0 0 0
	hyprctl keyword workspace f[1] m[0], gapsout:5 0 0 0
fi
