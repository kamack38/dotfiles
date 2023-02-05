#!/bin/bash

if dbus-send --system --dest=org.bluez --print-reply /org/bluez/hci0 org.freedesktop.DBus.Properties.Get string:org.bluez.Adapter1 string:Powered | grep -q 'true'; then
	bluetoothctl power off
else
	bluetoothctl power on
fi
