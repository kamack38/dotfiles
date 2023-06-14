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

# Default vars
HELPER="paru"
CURRENT_USER="$USER"

AWESOMEWM_PACKAGES=(
	"xorg"             # Display server
	"awesome-git"      # Highly configurable framework window manager
	"picom"            # A lightweight compositor for X11
	"betterlockscreen" # A simple, minimal lockscreen
	"autorandr"        # Auto-detect connected display hardware and load appropiate X11 setup using xrandr
	"polybar-git"      # Bar
	"ulauncher"        # Application launcher for Linux
	"clipster"         # Python clipboard manager
)

echo "${GREEN}:: ${BWHITE}Installing awesomeWM and its components...${NC}"
$HELPER -S --noconfirm --needed --quiet "${AWESOMEWM_PACKAGES[@]}"

# Enable services
sudo systemctl enable "betterlockscreen@$CURRENT_USER.service"
