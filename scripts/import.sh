#!/bin/bash

# Colours
BLACK=$'\e[0;30m'
WHITE=$'\e[0;37m'
BWHITE=$'\e[1;37m'
RED=$'\e[0;31m'
BLUE=$'\e[0;34m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
NC=$'\e[0m' # No Colour

# Vars
firefoxConfigPath="$HOME/.mozilla/firefox"
firefoxProfileName="Profile0"
backupDir="$HOME/.backup"
backupFile="$HOME/backup.tar.gz"

mkdir -p "$backupDir"

# Extract tar archive
if ! command -v crabz &>/dev/null || ! command -v pv &>/dev/null; then
	echo "${YELLOW}:: ${BWHITE}It seems that you don't have ${BLUE}crabz${BWHITE} and/or ${BLUE}pv${BWHITE} installed.${NC}"
	echo "${YELLOW}:: ${BWHITE}Extraction will be performed using only one core.${NC}"
	tar -xf "$backupFile" -C="$backupDir"
else
	echo "${BLUE}:: ${BWHITE}Extracting with multiple cores using ${BLUE}crabz${BWHITE}.${NC}"
	pv "$backupFile" | tar -I crabz -xf -C="$backupDir"
fi

# Copy firefox settings
firefoxProfilePath=$(sed -nr "/^\[$firefoxProfileName\]/ { :l /^Path[ ]*=/ { s/[^=]*=[ ]*//; p; q;}; n; b l;}" "$backupDir/firefox/profiles.ini")

declare -A paths
paths=(
	["firefox/$firefoxProfilePath"]="$firefoxConfigPath/$firefoxProfilePath"
	["firefox/profiles.ini"]="$firefoxConfigPath/profiles.ini"

	# Documents
	["Pictures"]="$HOME/Pictures"
	["Videos"]="$HOME/Videos"
	["Documents"]="$HOME/Documents"
	["Music"]="$HOME/Music"

	[".keys"]="$HOME/.keys"
	[".ssh"]="$HOME/.ssh"

	[".config/ngrok"]="$HOME/.config/ngrok"
	[".config/polybar/scripts/gmail/credentials.json"]="$HOME/.config/polybar/scripts/gmail/credentials.json"
	[".config/wakatime/.wakatime.cfg"]="$HOME/.config/wakatime/.wakatime.cfg"
)

for path in "${!paths[@]}"; do
	mv "$backupDir/$path" "${paths[$path]}"
done

# Import gpg keys
gpg --import "$HOME/.keys/backupkeys.pgp"
rm "$HOME/.keys/backupkeys.pgp"

# Remove .backup directory
rm -rf "$backupDir"
rm -f "$HOME/backup.tar.gz"
