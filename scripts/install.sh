#!/bin/env bash

set -e
# Colours
BLACK='\033[0;30m'
WHITE='\033[0;37m'
BWHITE='\033[1;37m'
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Colour

# Default vars
HELPER="paru"
DOTFILES="$HOME/.dotfiles"
REPO="https://github.com/kamack38/linux-dotfiles.git"
neovimConfigDir="$HOME/.config/nvim"
NVCHAD_URL="https://github.com/NvChad/NvChad"

# Show greetings
echo -e "   ___  __    _____ ______  ________  ________"
echo -e "  |\  \|\  \ |\   _ \  _  \|\_____  \|\   __  \ "
echo -e "  \ \  \/  /|\ \  \\\\\__\ \  \|_____\  \ \  \|\  \    Kamack38"
echo -e "   \ \   ___  \ \  \\\\|__| \  \|______  \ \   __  \   ${BLUE}https://twitter.com/kamack38${NC}"
echo -e "    \ \  \\\\ \  \ \  \    \ \  \| ____\  \ \  \|\  \  https://github.com/kamack38"
echo -e "     \ \__\\\\ \__\ \__\    \ \__\|\_______\ \_______\ "
echo -e "      \|__| \|__|\|__|     \|__|\|_______|\|_______|"
echo ""
echo -e "		${RED}Thank you for using my script!${NC}"

echo -e "${BLUE}:: ${BWHITE}Doing a system update, cause stuff may break if it's not the latest version...${NC}"
sudo pacman --noconfirm -Syu

echo -e "${BLUE}:: ${BWHITE}Installing basic packages...${NC}"
sudo pacman -S --noconfirm --needed base-devel wget git

# Create dirs
echo -e "${BLUE}:: ${BWHITE}Creating directories...${NC}"
mkdir -p $HOME/.local/share/fonts
mkdir -p $neovimConfigDir
mkdir -p $HOME/.srcs

if ! command -v $HELPER &>/dev/null; then
	echo -e "${YELLOW}It seems that you don't have $HELPER installed, I'll install that for you before continuing.${NC}"
	git clone https://aur.archlinux.org/$HELPER.git $HOME/.srcs/$HELPER
	(cd $HOME/.srcs/$HELPER/ && makepkg --noconfirm -si)
fi

echo -e "${GREEN}:: ${BWHITE}Installing packages using ${BLUE}${HELPER}${NC}"
$HELPER -S --noconfirm --needed --quiet ripgrep \
	python \
	python-pip \
	snapd \
	flatpak \
	bat \
	exa \
	croc \
	yt-dlp \
	ffmpeg \
	mpv \
	firefox-developer-edition \
	jre-openjdk \
	git-delta \
	onefetch \
	neofetch-git \
	neovim \
	fish \
	fisher \
	github-cli \
	caprine \
	libqalculate \
	qalculate-qt \
	visual-studio-code-bin \
	ff2mpv-native-messaging-host-git \
	oh-my-posh-bin \
	fzf \
	gnome-keyring \
	libsecret \
	tldr \
	procs \
	dust \
	bottom \
	shfmt-bin \
	cava \
	ngrok \
	ttf-font-awesome \
	rofi \
	jq \
	playerctl \
	mpv-mpris \
	spotify \
	spicetify-cli \
	update-grub \
	gnupg \
	unrar \
	gdb \
	mangohud \
	wakatime \
	ueberzug \
	bash-language-server \
	typescript-language-server \
	prettierd \
	ccls

# Install pip packages
echo -e "${GREEN}:: ${BWHITE}Installing ${BLUE}pip${BWHITE} packages${NC}"
pip install dbus-python
pip install neovim

# Add .local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Install node & npm packages
echo -e "${GREEN}:: ${BWHITE}Installing ${BLUE}node${BWHITE} & ${BLUE}npm${BWHITE} packages${NC}"
fish -c 'fisher install jorgebucaran/nvm.fish && nvm install lts && nvm use lts && set --universal nvm_default_version lts'
fish -c 'npm i -g carbon-now-cli \
	yarn \
	pm2 \
	neovim \
	npm-check-updates \
	git-cz'

echo -e "${GREEN}:: ${BWHITE}Installing ${BLUE}quokka.js plugins${NC}"
fish -c 'npm i --prefix $HOME/.quokka dotenv-quokka-plugin \
	jsdom-quokka-plugin'

# Install spicetify-cli themes
echo -e "${BLUE}:: ${BWHITE}Installing ${BLUE}spicetify themes${NC}"
git clone https://github.com/spicetify/spicetify-themes.git $HOME/.config/spicetify/Themes/

# Install NvChad
if [[ -d $neovimConfigDir/.git && $(git -C $neovimConfigDir ls-remote --get-url) != $NVCHAD_URL ]]; then
	echo -e "${BLUE}:: ${BWHITE}Installing ${BLUE}NvChad${NC}"
	mv $neovimConfigDir $HOME/.config/NVIM.BAK
	git clone https://github.com/NvChad/NvChad $neovimConfigDir --depth 1

	nvim \
		+'autocmd User PackerComplete sleep 100m | write $HOME/.packer.sync.result | qall' \
		+PackerSync
	cat $HOME/.packer.sync.result | grep -v 'Press'
else
	echo -e "${YELLOW}:: ${BLUE}NvChad${BWHITE} is already installed!${NC}"
fi

# Set default shell to fish
if [ ! "$(basename -- "$SHELL")" = "fish" ]; then
	echo -e "${YELLOW}:: ${BWHITE}Setting default shell to ${BLUE}fish${NC}"
	sudo chsh -s /bin/fish $USER
fi

echo -e "${YELLOW}:: ${BWHITE}Cloning ${BLUE}dotfiles${NC} from ${BLUE}${REPO#*//*/}${NC}"
git clone --bare $REPO $DOTFILES
git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
git --git-dir="$DOTFILES" --work-tree="$HOME" checkout --force

# Update submodules
echo -e "${BLUE}:: ${BWHITE}Updating ${BLUE}submodules${NC}"
git dtf submodule update --remote

echo "Which DE do you want to install?"
read -r -p "1) None 2) KDE 3) xfce (Default = 1): " de_script

case $de_script in

2)
	echo "Installing KDE..."
	bash "$HOME/scripts/kde.sh"
	;;

3)
	echo "Installing xfce..."
	bash "$HOME/scripts/xfce.sh"
	;;
*)
	echo "Skipping..."
	;;
esac

read -r -p "Do you want to setup additional programming fonts? [y/N] " fonts_setup

if [[ $fonts_setup == y* ]]; then
	echo "Running font script..."
	bash $HOME/scripts/fonts.sh
fi

read -r -p "Do you want to add additional pacman repositories (chaotic-aur, blackarch, multilib, archcraft)? [y/N] " repos_script

if [[ $repos_script == y* ]]; then
	echo "Running repos script..."
	bash $HOME/scripts/repos.sh
fi

read -r -p "Do you want to run script for asus laptops? [y/N] " asus_script

if [[ $asus_script == y* ]]; then
	echo "Running asus script..."
	bash $HOME/scripts/asus.sh
fi

read -r -p "Do you want to run script for razer hardware? [y/N] " razer_script

if [[ $razer_script == y* ]]; then
	echo "Running razer script..."
	bash $HOME/scripts/razer.sh
fi

read -r -p "Do you want to reboot? [y/N] " reboot_prompt

if [[ $reboot_prompt == y* ]]; then
	echo "Rebooting..."
	systemctl reboot
fi
