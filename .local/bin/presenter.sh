#!/bin/env bash

if ! kitty @ get-colors &>/dev/null; then
	echo "Error: Could not communicate with Kitty."
	echo "Ensure 'allow_remote_control yes' is set in your kitty.conf"
	exit 1
fi

# Extract the background color HEX string (e.g., #1e1e2e) from current window
BG_HEX=$(kitty @ get-colors | awk '/^background/ {print $2}')
DARK_BG="#1e2127"

if [ "$BG_HEX" = "$DARK_BG" ]; then
	kitty +kitten themes --reload-in=all "One Half Light"
	hyprctl keyword monitor HDMI-A-1,preferred,auto,1,mirror,DP-1
	sleep 0.1
	kitten @ set-font-size 32
	nvim -c 'lua require("base46").toggle_theme()' -c 'q'
else
	kitty +kitten themes --reload-in=all "One Dark Pro"
	kitten @ set-font-size 0
	nvim -c 'lua require("base46").toggle_theme()' -c 'q'
fi
