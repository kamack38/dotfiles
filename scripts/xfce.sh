#!/bin/env bash

set -e

#Default vars
HELPER="paru"
$HELPER -S --noconfirm --needed --quiet xorg \
    xfce4 \
    xfce4-goodies \
    lightdm \
    lightdm-gtk-greeter

# Enable services
sudo systemctl enable lightdm
