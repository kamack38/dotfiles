#!/bin/bash

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

# Add asusctl repository
source "$HOME/scripts/repos.sh"
g14

# Refresh repositories
echo "${BLUE}:: ${BWHITE}Refreshing repositories...${NC}"
sudo pacman -Syy

# Install packages
echo "${BLUE}:: ${BWHITE}Installing packages...${NC}"
$HELPER -S --noconfirm --needed --quiet asusctl \
	nvidia-prime

# Set keyboard light
echo "${BLUE}:: ${BWHITE}Setting keyboard light...${NC}"
asusctl led-mode rainbow -d right -s low

# Install custom kernel
echo "${BLUE}:: ${BWHITE}Installing g14 kernel...${NC}"
$HELPER -S --noconfirm --needed --quiet linux-g14 \
	linux-g14-headers

# Enable daemons
echo "${BLUE}:: ${BWHITE}Enabling daemons...${NC}"
systemctl --user enable --now asus-notify

echo "${BLUE}:: ${BWHITE}Blacklisting ${BLUE}nouveau${BWHITE}...${NC}"
sudo tee /etc/modprobe.d/blacklist-nvidia-nouveau.conf >/dev/null <<EOT
blacklist nouveau
options nouveau modeset=0
EOT

echo "${BLUE}:: ${BWHITE}Running mkinitcpio...${NC}"
sudo mkinitcpio -P

# slow internet
# sudo sysctl net.ipv4.tcp_ecn=0
