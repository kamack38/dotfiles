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

gh auth login
gh config set -h github.com git_protocol https
gh completion -s fish >"$XDG_DATA_HOME/fish/vendor_completions.d/gh.fish"

read -rp "${YELLOW}:: ${BWHITE}Do you want to import your public key from ${BLUE}Yubikey${BHWITE}? [Y/n]${NC}: " import
if [ $import != n* ]; then
	echo "fetch" | gpg --command-fd=0 --card-edit
fi
