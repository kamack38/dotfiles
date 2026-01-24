#!/bin/env bash

# The icons are provided by the 'g14/rog-control-center' package or 'cachyos/asusctl'

# Switch to the next profile
asusctl profile next

MESSAGE="$(asusctl profile get | head -n 1)"
PROFILE="$(echo $MESSAGE | awk '{print $NF}')"
case "$PROFILE" in
"Quiet" | "LowPower")
	ICON_COLOR="green"
	;;
"Balanced")
	ICON_COLOR="blue"
	;;
"Performance")
	ICON_COLOR="red"
	;;
esac
ICON="/usr/share/icons/hicolor/512x512/apps/asus_notif_${ICON_COLOR}.png"

notify-send "$(asusctl profile get | head -n 1)" -r 68 -i "$ICON"
