#!/bin/env bash

# Allow setting backlight

# Get backlight card
CARD=$(ls /sys/class/backlight/ | awk '{print $1 }')

sudo groupadd video
sudo usermod -aG video $USER
echo "RUN+=\"/bin/chgrp video /sys/class/backlight/$CARD/brightness\"" | sudo tee -a /etc/udev/rules.d/backlight.rules
echo "RUN+=\"/bin/chmod g+w /sys/class/backlight/$CARD/brightness\"" | sudo tee -a /etc/udev/rules.d/backlight.rules

# From Arch Wiki (doesn't work)
# echo "ACTION==\"add\", SUBSYSTEM==\"backlight\", KERNEL==\"$CARD\", GROUP=\"video\", MODE=\"0664\"" | sudo tee -a /etc/udev/rules.d/backlight.rules
