#!/bin/bash

# Vars
firefoxConfigPath="$HOME/.mozilla/firefox"
firefoxProfileName="Profile0"
backupDir="$HOME/.backup"

# Extract tar archive
if ! command -v pigz &>/dev/null; then
    echo "${YELLOW}:: ${BWHITE}It seems that you don't have ${BLUE}pigz${BWHITE} installed.${NC}"
    echo "${YELLOW}:: ${BWHITE}Extraction will be performed using only one core.${NC}"
    tar -xf "$HOME/backup.tar.gz" -C=$backupDir
else
    echo "${BLUE}:: ${BWHITE}Compressing with multiple cores using ${BLUE}pigz${BWHITE}.${NC}"
    tar --totals=USR1 -xf --use-compress-program=pigz "$HOME/backup.tar.gz" -C=$backupDir
fi

# Copy firefox settings
firefoxProfilePath=$(sed -nr "/^\[$firefoxProfileName\]/ { :l /^Path[ ]*=/ { s/[^=]*=[ ]*//; p; q;}; n; b l;}" "$backupDir/firefox/profiles.ini")

mv -f "$backupDir/firefox/$firefoxProfilePath" "$firefoxConfigPath/$firefoxProfilePath"
mv -f "$backupDir/firefox/profiles.ini" "$firefoxConfigPath/profiles.ini"

# Copy documents
mv -f "$backupDir/Pictures" "$HOME/Pictures"
mv -f "$backupDir/Videos" "$HOME/Videos"
mv -f "$backupDir/Documents" "$HOME/Documents"

# Copy ngrok settings
mv -f "$backupDir/.config/ngrok" "$HOME/.config/ngrok"

# Copy tokens/keys
mv -f "$backupDir/.keys" "$HOME/.keys"

# Copy wakatime settings
mv - "$backupDir/.config/wakatime/.wakatime.cfg" "$HOME/.config/wakatime/.wakatime.cfg"

# Copy ssh settings
mv -f "$backupDir/.ssh" "$HOME/.ssh"

# Copy gmail key
mv -f "$backupDir/.config/polybar/scripts/gmail/credentials.json" "$HOME/.config/polybar/scripts/gmail/credentials.json"

# Import gpg keys
gpg --import "$HOME/.keys/backupkeys.pgp"
rm "$HOME/.keys/backupkeys.pgp"

# Remove .backup directory
rm -rf "$backupDir"
rm -f "$HOME/backup.tar.gz"
