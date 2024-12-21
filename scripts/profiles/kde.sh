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

# Default vars
HELPER="paru"

KDE_PACKAGES=(
	"plasma-meta"                             # Plasma meta package
	"kdeplasma-addons"                        # Plasma addons
	"plasma6-wallpapers-wallpaper-engine-git" # Support for wallpaper engine wallpapers
	"spectacle"                               # Screenshot tool
	"latte-dock"                              # KDE dock
	"plasma-browser-integration"              # Integrate browser and plasma
	"polybar"                                 # A fast and easy-to-use status bar
	"python-gobject"                          # Ui creation (polybar mpris support)
	"rofi"                                    # Application launcher for Linux
	"clipster"                                # Python clipboard manager
)

echo "${GREEN}:: ${BWHITE}Installing KDE and its components...${NC}"
$HELPER -S --noconfirm --needed --quiet "${KDE_PACKAGES[@]}"

function installKDEPackage {
	# $1 - package id
	pkgUrl=$(curl -sL "https://store.kde.org/p/$1/loadFiles" | jq -r '.files[0].url' | sed 's#%3A#:#g' | sed 's#%2F#/#g')
	pkgName=$(curl -sL "https://store.kde.org/p/$1/loadFiles" | jq -r '.files[0].name')
	wget -qO "/tmp/$pkgName" "$pkgUrl"
	kpackagetool5 --install "/tmp/$pkgName"
}

# Download themes

# MMcK Launcher: https://store.kde.org/p/1720532/
installKDEPackage 1720532
# QuarksSplashDarkMaterial: https://store.kde.org/p/1401872/
installKDEPackage 1401872
# Desert plasma: https://store.kde.org/p/1733294/
installKDEPackage 1733294
# Venture: https://store.kde.org/p/1719504
installKDEPackage 1719504
