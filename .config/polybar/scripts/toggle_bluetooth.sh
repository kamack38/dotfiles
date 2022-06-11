#!/bin/sh
# Source https://github.com/msaitz/polybar-bluetooth/blob/master/toggle_bluetooth.sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]; then
  bluetoothctl power on
else
  bluetoothctl power off
fi
