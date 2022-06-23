#!/bin/bash

# Vars
firefoxConfigPath="$HOME/.mozilla/firefox"
firefoxProfileName="Profile0"
backupDir="$HOME/.backup"

# Extract tar archive
tar -xvf "$HOME/backup.tar.gz" --directory=$backupDir

# Copy firefox settings
firefoxProfilePath=$(sed -nr "/^\[$firefoxProfileName\]/ { :l /^Path[ ]*=/ { s/[^=]*=[ ]*//; p; q;}; n; b l;}" "$backupDir/firefox/profiles.ini")

cp -rf "$backupDir/firefox/$firefoxProfilePath" "$firefoxConfigPath/$firefoxProfilePath"
cp -rf "$backupDir/firefox/profiles.ini" "$firefoxConfigPath/profiles.ini"

# Copy documents
cp -rf "$backupDir/Pictures" "$HOME/Pictures"
cp -rf "$backupDir/Videos" "$HOME/Videos"
cp -rf "$backupDir/Documents" "$HOME/Documents"

# Copy ngrok settings
cp -rf "$backupDir/.config/ngrok" "$HOME/.config/ngrok"

# Copy tokens/keys
cp -rf "$backupDir/.keys" "$HOME/.keys"

# Copy wakatime settings
cp -f "$backupDir/.wakatime.cfg" "$HOME/.wakatime.cfg"

# Copy ssh settings
cp -rf "$backupDir/.ssh" "$HOME/.ssh"

# Copy gmail key
cp -rf "$backupDir/.config/polybar/scripts/gmail/credentials.json" "$HOME/.config/polybar/scripts/gmail/credentials.json"

# Import gpg keys
gpg --import "$HOME/.keys/backupkeys.pgp"
rm "$HOME/.keys/backupkeys.pgp"

# Remove .backup directory
rm -rf "$backupDir"
rm -f "$HOME/backup.tar.gz"
