#!/bin/bash

# Vars
firefoxConfigPath="$HOME/.mozilla/firefox"
firefoxProfileName="Profile0"
backupDir="$HOME/.backup"

# Create backup directory
mkdir -p "$backupDir/firefox"

# Copy firefox settings
firefoxProfilePath=$(sed -nr "/^\[$firefoxProfileName\]/ { :l /^Path[ ]*=/ { s/[^=]*=[ ]*//; p; q;}; n; b l;}" "$firefoxConfigPath/profiles.ini")

cp -rf "$firefoxConfigPath/$firefoxProfilePath" "$backupDir/firefox/$firefoxProfilePath"
cp -rf "$firefoxConfigPath/profiles.ini" "$backupDir/firefox/profiles.ini"

# Copy ngrok settings
cp -rf "$HOME/.config/ngrok" "$backupDir/.config/ngrok"

# Copy tokens/keys
cp -rf "$HOME/.keys" "$backupDir/.keys"

# Copy wakatime settings
cp -f "$HOME/.wakatime.cfg" "$backupDir/.wakatime.cfg"

# Copy ssh settings
cp -rf "$HOME/.ssh" "$backupDir/.ssh"

# Copy gmail key
cp -rf "$HOME/.config/polybar/scripts/gmail/credentials.json" "$backupDir/.config/polybar/scripts/gmail/credentials.json"

# Backup gpg keys
gpg --output "$backupDir/.keys/backupkeys.pgp" --armor --export-secret-keys --export-options export-backup

# Create a tar archive
tar -czvf backup.tar.gz --directory="$backupDir" .

# Remove .backup directory
rm -rf "$backupDir"
