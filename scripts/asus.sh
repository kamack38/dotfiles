#!/bin/bash

HELPER="paru"

# Add asusctl repo
if grep -Fxq "[g14]" /etc/pacman.conf; then
	echo "g14 repo already exists"
else
	sudo tee -a /etc/pacman.conf >/dev/null <<EOT
[g14]
SigLevel = DatabaseNever Optional TrustAll
Server = https://arch.asus-linux.org
EOT
fi

# Refresh repositories
sudo pacman -Syy

# Install packages
$HELPER -S --noconfirm --needed --quiet asusctl-git \
	alsa-tools \
	optimus-manager \
	optimus-manager-qt \
	polybar-git

# Set keyboard light
asusctl led-mode rainbow -d right -s low

# Install custom kernel
$HELPER -S --noconfirm --needed --quiet linux-g14 \
	linux-g14-headers

# Enable daemons
systemctl --user enable asus-notify
systemctl --user start asus-notify

# slow internet
# sudo sysctl net.ipv4.tcp_ecn=0

# nivida
# sudo mkinitcpio -P
