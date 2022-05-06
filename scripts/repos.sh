#!/bin/bash

# Add archcraft repo
if grep -Fxq "[archcraft]" /etc/pacman.conf; then
	echo "Archcraft repo already exists"
else
	sudo wget 'https://raw.githubusercontent.com/archcraft-os/core-packages/main/archcraft-mirrorlist/archcraft-mirrorlist' -O /etc/pacman.d/archcraft-mirrorlist
	sudo tee -a /etc/pacman.conf >/dev/null <<EOT
[archcraft]
SigLevel = Optional TrustAll
Include = /etc/pacman.d/archcraft-mirrorlist
EOT
fi

# Add chaotic aur
if grep -Fxq "[chaotic-aur]" /etc/pacman.conf; then
	echo "Chaotic-aur repo already exists"
else
	sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
	sudo pacman-key --lsign-key FBA220DFC880C036
	sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
	sudo tee -a /etc/pacman.conf >/dev/null <<EOT
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOT
fi

# Add multilib repo
if grep -Fxq "[multilib]" /etc/pacman.conf; then
	echo "Multilib repo already exists"
else
	sudo tee -a /etc/pacman.conf >/dev/null <<EOT
[multilib]
Include = /etc/pacman.d/mirrorlist
EOT
fi

# Add blackarch repo
curl -s https://blackarch.org/strap.sh | sudo bash
