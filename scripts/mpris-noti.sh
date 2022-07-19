#!/bin/env bash
notify-send -i $(playerctl metadata mpris:artUrl) "$(playerctl status): $(playerctl metadata xesam:artist) - $(playerctl metadata xesam:title)
Vol: $(($(playerctl volume | sed 's/0.//') / 10000))%"
