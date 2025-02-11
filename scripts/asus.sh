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

echo "${BLUE}:: ${BWHITE}Fixing sound...${NC}"
sudo tee /etc/modprobe.d/hda-jack-retask.conf >/dev/null <<EOF
options snd-hda-intel patch=hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw
EOF

sudo tee /lib/firmware/hda-jack-retask.fw >/dev/null <<EOF
[codec]
0x10ec0285 0x10431602 0

[pincfg]
0x12 0x90a60140
0x13 0x40000000
0x14 0x90170152
0x16 0x411111f0
0x17 0x90170110
0x18 0x411111f0
0x19 0x03a19020
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x40663a45
0x1e 0x90170151
0x21 0x03211020
EOF

echo "${BLUE}:: ${BWHITE}Running mkinitcpio...${NC}"
sudo mkinitcpio -P

# Fix slow internet
# sudo sysctl net.ipv4.tcp_ecn=0

# Powersave Tweaks

# Disable NMI Watchdog
# - The NMI watchdog is a debugging feature to catch hardware hangs that cause a kernel panic. On some systems it can generate a lot of interrupts, causing a noticeable increase in power usag
sudo tee /etc/sysctl.d/disable_nmi_watchdog.conf >/dev/null <<EOF
kernel.nmi_watchdog = 0
EOF

# Suspend when battery is at 2%
sudo tee /etc/udev/rules.d/50-powersave-suspend.rules >/dev/null <<EOF
# Suspend when battery is at 2%
SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="2", RUN+="/usr/bin/systemctl suspend"
EOF
