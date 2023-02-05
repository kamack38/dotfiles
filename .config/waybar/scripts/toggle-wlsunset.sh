#!/bin/bash

if pgrep -x "wlsunset" >/dev/null; then
	killall wlsunset
else
	if ! command -v wlsunset &>/dev/null; then
		notify-send "wlsunset isn't installed"
		exit
	fi
	wlsunset &
fi
