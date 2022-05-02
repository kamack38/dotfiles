#!/bin/bash

HELPER="paru"

$HELPER -S --noconfirm --needed --quiet asusctl-git \
    alsa-tools \
    optimus-manager \
    optimus-manager-qt \
    polybar

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
# sudo tee -a /etc/pacman.conf >/dev/null <<EOT
# [multilib]
# Include = /etc/pacman.d/mirrorlist
# EOT

# slow internet
# sudo sysctl net.ipv4.tcp_ecn=0

# nivida
# sudo mkinitcpio -P
