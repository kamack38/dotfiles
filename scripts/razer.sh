#!/bin/bash

HELPER="paru"

echo "Installing razer drivers & RGB software..."
$HELPER -S --noconfirm --needed --quiet polychromatic-git \
    openrazer-meta-git

# Add current user to plugdev group
CURRENT_USER="$USER"
sudo gpasswd -a $CURRENT_USER plugdev
