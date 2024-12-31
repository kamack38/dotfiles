#!/bin/env bash
current_workspace=$(hyprctl activewindow -j | jq '.workspace.id')

if [ "$current_workspace" != "-99" ]; then
	hyprctl dispatch movetoworkspace special
else
	hyprctl dispatch movetoworkspace $(hyprctl activeworkspace -j | jq '.id')
fi
