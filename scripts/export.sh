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

# Copy firefox settings
echo "${BLUE}:: ${BWHITE}Finding default firefox profile path...${NC}"
firefoxProfilePath=$(sed -nr "/^\[$firefoxProfileName\]/ { :l /^Path[ ]*=/ { s/[^=]*=[ ]*//; p; q;}; n; b l;}" "$firefoxConfigPath/profiles.ini")
echo "${GREEN}:: ${BWHITE}Path found! ($firefoxProfilePath)${NC}"

# Backup gpg keys
echo "${BLUE}:: ${BWHITE}Backing up GPG keys...${NC}"
gpg --output "$HOME/.keys/backupkeys.pgp" --armor --export-secret-keys --export-options export-backup

DIR_TO_BACKUP=(
	".config/ngrok"
	".config/wakatime/.wakatime.cfg"
	".ssh"
	".config/polybar/scripts/gmail/credentials.json"
	".keys"
	"Pictures"
	"Videos"
	"Documents"
	"Music"
	".mozilla/firefox/$firefoxProfilePath"
	".mozilla/firefox/profiles.ini"
)

# Create a tar archive
BACKUP_PATH="$HOME/backup-$(date +%m-%Y).tar.gz"
if ! command -v crabz &>/dev/null; then
	echo "${YELLOW}:: ${BWHITE}It seems that you don't have ${BLUE}pigz${BWHITE} installed.${NC}"
	echo "${YELLOW}:: ${BWHITE}Compression will be performed using only one core.${NC}"
	tar -C "$HOME" -czvf "$HOME/backup.tar.gz" "${DIR_TO_BACKUP[@]}"
else
	echo "${BLUE}:: ${BWHITE}Compressing with multiple cores using ${BLUE}crabz${BWHITE}.${NC}"
	tar -cf - -C "$HOME" --exclude='**node_modules' "${DIR_TO_BACKUP[@]}" | pv -s "$(du -sbc "${DIR_TO_BACKUP[@]}" | grep 'total' | awk '{ print $1 }')" | crabz >"$BACKUP_PATH"
fi

# Clean up
echo "${YELLOW}:: ${BWHITE}Cleaning up...${NC}"
rm -f "$HOME/.keys/backupkeys.pgp"

echo "${GREEN}:: ${BWHITE}Your backup is in ${BLUE}${BACKUP_PATH}${NC}"
