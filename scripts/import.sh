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

# Copy ngrok settings
cp -rf "$backupDir/.config/ngrok" "$HOME/.config/ngrok"

# Copy tokens/keys
cp -rf "$HOME/.keys" "$backupDir/.keys"

# Import gpg keys
gpg --import "$backupDir/.keys/backupkeys.pgp"
rm $backupDir/.keys/backupkeys.pgp

# Copy tokens/keys
cp -rf "$backupDir/.keys" "$HOME/.keys"

# Remove .backup directory
rm -rf "$backupDir"
rm -f "$HOME/backup.tar.gz"
