#!/bin/bash

# Colours
BWHITE=$'\e[1;37m'
BLUE=$'\e[0;34m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
NC=$'\e[0m' # No Colour

archcraft() {
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

chaotic_aur() {
	if grep -Fxq "[chaotic-aur]" /etc/pacman.conf; then
		echo "${YELLOW}:: ${BLUE}chaotic-aur ${BWHITE}repo already exists${NC} -- skipping"
	else
		echo "${BLUE}:: ${BWHITE}Adding ${BLUE}chaotic-aur ${BWHITE}repository${NC}"
		sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
		sudo pacman-key --lsign-key FBA220DFC880C036
		sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
		sudo tee -a /etc/pacman.conf >/dev/null <<EOT

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOT
	fi
}

garuda() {
	if grep -Fxq "[garuda]" /etc/pacman.conf; then
		echo "${YELLOW}:: ${BLUE}garuda ${BWHITE}repo already exists${NC} -- skipping"
	else
		echo "${BLUE}:: ${BWHITE}Adding ${BLUE}garuda ${BWHITE}repository${NC}"
		sudo tee -a /etc/pacman.conf >/dev/null <<EOT

[garuda]
Include = /etc/pacman.d/chaotic-mirrorlist
EOT
	fi
}

multilib() {
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

blackarch() {
	if grep -Fxq "[blackarch]" /etc/pacman.conf; then
		echo "${YELLOW}:: ${BLUE}blackarch ${BWHITE}repo already exists${NC} -- skipping"
	else
		echo "${BLUE}:: ${BWHITE}Adding ${BLUE}blackarch ${BWHITE}repository${NC}"
		curl -s https://blackarch.org/strap.sh | sudo bash
	fi
}

archstrike() {
	if grep -Fxq "[archstrike]" /etc/pacman.conf; then
		echo "${YELLOW}:: ${BLUE}archstrike ${BWHITE}repo already exists${NC} -- skipping"
	else
		echo "${BLUE}:: ${BWHITE}Adding ${BLUE}archstrike ${BWHITE}repository${NC}"
		sudo tee -a /etc/pacman.conf >/dev/null <<'EOT'

[archstrike]
Server = https://mirror.archstrike.org/$arch/$repo
EOT
		sudo pacman-key -r 9D5F1C051D146843CDA4858BDE64825E7CBC0D51
		sudo pacman-key --lsign-key 9D5F1C051D146843CDA4858BDE64825E7CBC0D51
		sudo pacman -Sy archstrike-keyring archstrike-mirrorlist --noconfirm
		sudo sed -i 's#Server = https://mirror.archstrike.org/$arch/$repo#Include = /etc/pacman.d/archstrike-mirrorlist#' /etc/pacman.conf
	fi
}

asusctl() {
	if grep -Fxq "[g14]" /etc/pacman.conf; then
		echo "g14 repo already exists"
	else
		sudo tee -a /etc/pacman.conf >/dev/null <<EOT
[g14]
SigLevel = DatabaseNever Optional TrustAll
Server = https://arch.asus-linux.org
EOT
	fi
}
