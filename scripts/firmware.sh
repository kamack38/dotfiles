#!/bin/env bash

# Mapping of common lspci vendor names to linux-firmware packages
declare -A VENDOR_PKG_MAP=(
	["Intel"]="linux-firmware-intel"
	["AMD"]="linux-firmware-amdgpu linux-firmware-radeon"
	["Advanced Micro Devices"]="linux-firmware-amdgpu linux-firmware-radeon"
	["NVIDIA"]="linux-firmware-nvidia"
	["Realtek"]="linux-firmware-realtek"
	["Qualcomm"]="linux-firmware-atheros linux-firmware-qcom"
	["Atheros"]="linux-firmware-atheros"
	["Broadcom"]="linux-firmware-broadcom"
	["Marvell"]="linux-firmware-marvell"
	["MediaTek"]="linux-firmware-mediatek"
	["Cirrus"]="linux-firmware-cirrus"
	["QLogic"]="linux-firmware-qlogic"
	["Mellanox"]="linux-firmware-mellanox"
	["Cavium"]="linux-firmware-liquidio"
	["Netronome"]="linux-firmware-nfp"
)

# Get unique vendors from lspci
VENDORS=$(lspci | cut -d':' -f3 | cut -d',' -f1 | sort -u)

PACKAGES_TO_INSTALL=""

while IFS= read -r vendor; do
	# Trim leading/trailing whitespace
	vendor=$(echo "$vendor" | xargs)

	for key in "${!VENDOR_PKG_MAP[@]}"; do
		if [[ "$vendor" == *"$key"* ]]; then
			PACKAGES_TO_INSTALL+=" ${VENDOR_PKG_MAP[$key]}"
		fi
	done
done <<<"$VENDORS"

# Remove duplicates
PACKAGES_TO_INSTALL=$(echo "$PACKAGES_TO_INSTALL" | tr ' ' '\n' | sort -u | tr '\n' ' ')

if [[ -n "$PACKAGES_TO_INSTALL" ]]; then
	echo "Detected vendors requiring firmware:"
	echo "$VENDORS"
	echo ""
	echo "Installing: $PACKAGES_TO_INSTALL"
	sudo pacman -S --needed $PACKAGES_TO_INSTALL
	sudo pacman -D --asexplicit $PACKAGES_TO_INSTALL
else
	echo "No matching firmware packages found for detected vendors."
fi
