#!/bin/env bash

set -e

#Default vars
HELPER="paru"
neovimConfigDir="$HOME/.config/nvim"

echo "Doing a system update, cause stuff may break if it's not the latest version..."
sudo pacman --noconfirm -Syu

sudo pacman -S --noconfirm --needed base-devel wget git

# Create dirs
mkdir -p $HOME/.local/share/fonts
mkdir -p $neovimConfigDir
mkdir -p $HOME/.srcs

if ! command -v $HELPER &>/dev/null; then
	echo "It seems that you don't have $HELPER installed, I'll install that for you before continuing."
	git clone https://aur.archlinux.org/$HELPER.git $HOME/.srcs/$HELPER
	(cd $HOME/.srcs/$HELPER/ && makepkg --noconfirm -si)
fi

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
pip install dbus-python
pip install neovim

# Add .local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Install node & npm packages
fish -c 'fisher install jorgebucaran/nvm.fish && nvm install lts && nvm use lts'
npm i -g carbon-now-cli \
	yarn \
	pm2 \
	neovim \
	npm-check-updates \
	git-cz

npm i --prefix $HOME/.quokka dotenv-quokka-plugin
npm i --prefix $HOME/.quokka jsdom-quokka-plugin

# Install spicetify-cli themes
git clone https://github.com/spicetify/spicetify-themes.git $HOME/.config/spicetify/Themes/

# Install NvChad
echo "Installing NvChad..."
mv $neovimConfigDir $HOME/.config/NVIM.BAK
git clone https://github.com/NvChad/NvChad $neovimConfigDir --depth 1

nvim \
	+'autocmd User PackerComplete sleep 100m | write $HOME/.packer.sync.result | qall' \
	+PackerSync
cat $HOME/.packer.sync.result | grep -v 'Press'

# Set default shell to fish
if [ ! "$(basename -- "$SHELL")" = "fish" ]; then
	sudo chsh -s /bin/fish $USER
fi

DOTFILES="$HOME/.dotfiles"
repo="https://github.com/kamack38/linux-dotfiles.git"

git clone --bare $repo $DOTFILES
git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
git --git-dir="$DOTFILES" --work-tree="$HOME" checkout --force

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
