#!/bin/env bash

set -e

#Default vars
HELPER="paru"
$HELPER -S --noconfirm --needed --quiet xorg \
	plasma-meta \
	networkmanager \
	kdeplasma-addons \
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
