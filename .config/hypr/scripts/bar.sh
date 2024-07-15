#!/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-~/.config}"

if hyprctl monitors -j | jq -e '.[] | select(.name == "DP-1") | length > 0'; then
	waybar -c "$XDG_CONFIG_HOME/waybar/config.jsonc"
else
	waybar -c "$XDG_CONFIG_HOME/waybar/laptop-config.jsonc"
fi
