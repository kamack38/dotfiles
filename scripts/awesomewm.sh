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
	"xorg"               # Display server
	"awesome-git"        # Highly configurable framework window manager
	"dolphin"            # File Manager
	"ark"                # Archive Manager
	"desktop-file-utils" # Command line utilities for working with desktop entries
	"partitionmanager"   # Partition Manager
	"kcron"              # Task scheduler
	"gwenview"           # Image viewer
	"qt5-imageformats"   # Add more image formats (webp)
	"sddm"               # QML based X11 and Wayland display manager
	"clipster"           # Python clipboard manager
	"brightnessctl"      # Lightweight brightness control tool
	"picom-jonaburg-git" # jonaburg's picom fork with tryone144's dual_kawase blur and ibhagwan's rounded corners, an X compositor (compton's fork)
	"betterlockscreen"   # A simple, minimal lockscreen
)

echo "${GREEN}:: ${BWHITE}Installing awesomeWM and its components...${NC}"
$HELPER -S --noconfirm --needed --quiet "${AWESOMEWM_PACKAGES[@]}"

# Enable services
if [[ $(systemctl is-enabled sddm-plymouth.service 2>/dev/null) == enabled ]]; then
	echo "${YELLOW}:: ${BWHITE}It seems that you have sddm-plymouth service enabled${NC} -- skipping sddm service"
else
	sudo systemctl enable sddm.service
fi
sudo systemctl enable "betterlockscreen@$CURRENT_USER.service"
