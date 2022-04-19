#!/bin/env bash

set -e

#Default vars
HELPER="paru"
$HELPER -S --noconfirm --needed --quiet xorg \
    plasma-meta \
    kde-applications \
    latte-dock

# Enable services
sudo systemctl enable ssdm
sudo systemctl enable NetworkManager

# Remove unnecessary dependencies
$HELPER -Rns --noconfirm konsole
