#!/bin/bash

# Colours
BWHITE=$'\e[1;37m'
BLUE=$'\e[0;34m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
NC=$'\e[0m' # No Colour

function archcraft {
	if grep -Fxq "[archcraft]" /etc/pacman.conf; then
		echo "${YELLOW}:: ${BLUE}archcraft ${BWHITE}repo already exists${NC} -- skipping"
	else
		echo "${BLUE}:: ${BWHITE}Adding ${BLUE}archcraft ${BWHITE}repository${NC}"
		sudo wget 'https://raw.githubusercontent.com/archcraft-os/core-packages/main/archcraft-mirrorlist/archcraft-mirrorlist' -O /etc/pacman.d/archcraft-mirrorlist
		sudo tee -a /etc/pacman.conf >/dev/null <<EOT
[archcraft]
SigLevel = Optional TrustAll
Include = /etc/pacman.d/archcraft-mirrorlist
EOT
	fi
}

function chaotic_aur {
	if grep -Fxq "[chaotic-aur]" /etc/pacman.conf; then
		echo "${YELLOW}:: ${BLUE}chaotic-aur ${BWHITE}repo already exists${NC} -- skipping"
	else
		echo "${BLUE}:: ${BWHITE}Adding ${BLUE}chaotic-aur ${BWHITE}repository${NC}"
		sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
		sudo pacman-key --lsign-key FBA220DFC880C036
		sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
		sudo tee -a /etc/pacman.conf >/dev/null <<EOT
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOT
	fi
}

function multilib {
	if grep -Fxq "[multilib]" /etc/pacman.conf; then
		echo "${YELLOW}:: ${BLUE}multilib ${BWHITE}repo already exists${NC} -- skipping"
	else
		echo "${BLUE}:: ${BWHITE}Adding ${BLUE}multilib ${BWHITE}repository${NC}"
		sudo tee -a /etc/pacman.conf >/dev/null <<EOT
[multilib]
Include = /etc/pacman.d/mirrorlist
EOT
	fi
}

function blackarch {
	if grep -Fxq "[blackarch]" /etc/pacman.conf; then
		echo "${YELLOW}:: ${BLUE}blackarch ${BWHITE}repo already exists${NC} -- skipping"
	else
		echo "${BLUE}:: ${BWHITE}Adding ${BLUE}blackarch ${BWHITE}repository${NC}"
		curl -s https://blackarch.org/strap.sh | sudo bash
	fi
}
