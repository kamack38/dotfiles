#!/bin/bash

TEMPERATURE="2500"

if ! pgrep -x "hyprsunset" >/dev/null; then
	hyprsunset &
	disown
fi

if [ $(cat /tmp/hyprsunset-state) = "enabled" ]; then
	notify-send "Disabling blue-light filter"
	hyprctl hyprsunset identity
	echo "disabled" >/tmp/hyprsunset-state
else
	notify-send "Enabling blue-light filter"
	hyprctl hyprsunset temperature $TEMPERATURE
	echo "enabled" >/tmp/hyprsunset-state
fi
