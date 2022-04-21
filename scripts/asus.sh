#!/bin/bash

HELPER="paru"

$HELPER -S --noconfirm --needed --quiet asusctl \
    alsa-tools \
    optimus-manager \
    optimus-manager-qt \
    openrgb-git \
    polybar \
    spectacle \
    latte-dock

# Add asusctl repo
sudo tee -a /etc/pacman.conf >/dev/null <<EOT
[g14]
SigLevel = DatabaseNever Optional TrustAll
Server = https://arch.asus-linux.org
EOT

# Add multilib repo
# sudo tee -a /etc/pacman.conf >/dev/null <<EOT
# [multilib]
# Include = /etc/pacman.d/mirrorlist
# EOT

# slow internet
# sudo sysctl net.ipv4.tcp_ecn=0

# nivida
# sudo mkinitcpio -P
