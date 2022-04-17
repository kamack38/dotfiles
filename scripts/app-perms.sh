#!/bin/env bash

# Get backlight card
CARD=$(ls /sys/class/backlight/ | awk '{print $1 }')

sudo groupadd video
sudo usermod -aG video $USER
echo "ACTION==\"add\", SUBSYSTEM==\"backlight\", KERNEL==\"$CARD\", GROUP=\"video\", MODE=\"0664\"" | sudo tee -a /etc/udev/rules.d/backlight.rules
