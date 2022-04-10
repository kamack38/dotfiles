#!/bin/env bash

set -e

#Default vars
HELPER="paru"
neovimConfigDir=~/.config/nvim

echo "Doing a system update, cause stuff may break if it's not the latest version..."
sudo pacman --noconfirm -Syu

sudo pacman -S --noconfirm --needed base-devel wget git

# Create dirs
mkdir -p ~/.local/share/fonts
mkdir -p neovimConfigDir
mkdir -p ~/.srcs

if ! command -v $HELPER &>/dev/null; then
    echo "It seems that you don't have $HELPER installed, I'll install that for you before continuing."
    git clone https://aur.archlinux.org/$HELPER.git ~/.srcs/$HELPER
    (cd ~/.srcs/$HELPER/ && makepkg --noconfirm -si)
fi

$HELPER -S --noconfirm --needed --quiet ripgrep \
    python \
    snapd \
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
    neofetch \
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
    nvm \
    gnome-keyring \
    libsecret \
    nerd-fonts-fira-code

if ! command -v nvm &>/dev/null; then
    echo "Loading nvm..."
    source /usr/share/nvm/init-nvm.sh
else
    echo "Nvm is already loaded!"
fi

if command -v node &>/dev/null; then
    echo "You have already installed Node.js! Skipping..."
else
    echo "Installing Node.js..."
    nvm install --lts
    nvm use --lts
fi

# Install npm packages
npm i -g carbon-now-cli \
    yarn \
    pm2 \
    neovim \
    npm-check-updates \
    git-cz

npm i --prefix ~/.quokka dotenv-quokka-plugin
npm i --prefix ~/.quokka jsdom-quokka-plugin

# Install NvChad
echo "Installing NvChad..."
mv $neovimConfigDir ~/.config/NVIM.BAK
git clone https://github.com/NvChad/NvChad $neovimConfigDir --depth 1

# nvim \
# +'autocmd User PackerComplete sleep 100m | write ~/.packer.sync.result | qall' \
# +PackerSync
# cat ~/.packer.sync.result | grep -v 'Press'

fish -c 'fisher install jorgebucaran/nvm.fish'

if [ ! "$(basename -- "$SHELL")" = "fish" ]; then
    # Set default shell
    sudo chsh -s /bin/fish $USER
fi

DOTFILES="$HOME/.dotfiles"
repo="https://github.com/kamack38/linux-dotfiles.git"

git clone --bare $repo $DOTFILES
git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
git --git-dir="$DOTFILES" --work-tree="$HOME" checkout --force

read -r -p "Do you want to setup NerdFonts? [y/N] " fonts_setup

if [[ $fonts_setup == "y*" ]]; then
    echo "Running script..."
    bash ~/script/fonts.sh
fi

read -r -p "Do you want to run script for asus laptops? [y/N] " asus_script

if [[ $asus_script == "y*" ]]; then
    echo "Running script..."
    bash ~/script/asus.sh
fi
