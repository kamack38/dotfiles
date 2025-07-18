#!/bin/env bash

# The icons are provided by the 'g14/rog-control-center' package or 'cachyos/asusctl'

# Switch to the next profile
asusctl profile -n

MESSAGE="$(asusctl profile -p | tail -n1)"
PROFILE="$(echo $MESSAGE | awk '{print $NF}')"
case "$PROFILE" in
"LowPower")
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

notify-send "$(asusctl profile -p | tail -n1)" -r 68 -i "$ICON"
