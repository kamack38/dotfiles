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

#Default vars
HELPER="paru"

KDE_PACKAGES=(
	"xorg"                                # Display server
	"plasma-meta"                         # Plasma meta package
	"networkmanager"                      # Network Manager
	"kdeplasma-addons"                    # Plasma addons
	"plasma5-wallpapers-wallpaper-engine" # Support for wallpaper engine wallpapers
	"spectacle"                           # Screenshot tool
	"latte-dock"                          # KDE dock
	"touchegg"                            # Touchpad gestures support
	"dolphin"                             # File Manager
	"ark"                                 # Archive Manager
	"desktop-file-utils"                  # Command line utilities for working with desktop entries
	"partitionmanager"                    # Partition Manager
	"kcron"                               # Task scheduler
	"gwenview"                            # Image viewer
	"qt5-imageformats"                    # Add more image formats (webp)
	"plasma-browser-integration"          # Integrate browser and plasma
)

echo "${GREEN}:: ${BWHITE}Installing KDE and its components...${NC}"
$HELPER -S --noconfirm --needed --quiet "${KDE_PACKAGES[@]}"

# Enable services
sudo systemctl enable sddm
sudo systemctl enable NetworkManager

sudo systemctl enable touchegg.service
sudo systemctl start touchegg

# Add archcraft repository
source "$HOME/scripts/repos.sh"
archcraft

sudo $HELPER -Sy

# Install styles/themes
echo "${BLUE}:: ${BWHITE}Installing KDE themes...${NC}"
$HELPER -S --noconfirm --needed --quiet lightly-qt \
	archcraft-backgrounds

function installKDEPackage {
	# $1 - package id
	pkgUrl=$(curl -sL "https://store.kde.org/p/$1/loadFiles" | jq -r '.files[0].url' | sed 's#%3A#:#g' | sed 's#%2F#/#g')
	pkgName=$(curl -sL "https://store.kde.org/p/$1/loadFiles" | jq -r '.files[0].name')
	wget -qO "/tmp/$pkgName" $pkgUrl
	kpackagetool5 --install "/tmp/$pkgName"
}

# Download themes

# OnzeMenu 11: https://store.kde.org/p/1545530
installKDEPackage 1545530
# QuarksSplashDarkMaterial: https://store.kde.org/p/1401872/
installKDEPackage 1401872
# Desert plasma: https://store.kde.org/p/1733294/
installKDEPackage 1733294
# Mega-Plasma: https://store.kde.org/p/1669395
# installKDEPackage 1669395
# Fluent round dark plasma: https://store.kde.org/p/1544466
# installKDEPackage 1544466
# Fluent cursors theme: https://store.kde.org/p/1499852
# installKDEPackage 1499852
