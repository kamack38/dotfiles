#!/bin/env bash

set -e

# Colours
BLACK=$'\e[0;30m'
WHITE=$'\e[0;37m'
BWHITE=$'\e[1;37m'
RED=$'\e[0;31m'
BLUE=$'\e[0;34m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
NC=$'\e[0m' # No Colour

#Default vars
HELPER="paru"

echo "${GREEN}:: ${BWHITE}Installing Xfce..."

# Install components
$HELPER -S --noconfirm --needed --quiet xorg \
    xfce4 \
    xfce4-goodies \
    lightdm \
    lightdm-gtk-greeter

# Enable services
sudo systemctl enable lightdm
