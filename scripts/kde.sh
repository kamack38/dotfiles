#!/bin/env bash

set -e

#Default vars
HELPER="paru"
$HELPER -S --noconfirm --needed --quiet xorg \
	plasma-meta \
	networkmanager \
	kdeplasma-addons \
	plasma5-wallpapers-wallpaper-engine \
	spectacle \
	latte-dock \
	touchegg \
	dolphin \
	ark \
	desktop-file-utils \
	partitionmanager \
	kcron

# Enable services
sudo systemctl enable sddm
sudo systemctl enable NetworkManager

sudo systemctl enable touchegg.service
sudo systemctl start touchegg

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
