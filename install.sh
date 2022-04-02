#!/usr/bin/env bash

sudo pacman -Sy --noconfirm --needed git
sudo pacman -Sy --noconfirm --needed base-devel
sudo pacman -Sy --noconfirm --needed wget
sudo pacman -Sy --noconfirm --needed ripgrep
sudo pacman -Sy --noconfirm --needed python
sudo pacman -Sy --noconfirm --needed code
sudo pacman -Sy --noconfirm --needed bat
sudo pacman -Sy --noconfirm --needed exa
sudo pacman -Sy --noconfirm --needed croc
sudo pacman -Sy --noconfirm --needed yt-dlp
sudo pacman -Sy --noconfirm --needed ffmpeg
sudo pacman -Sy --noconfirm --needed mpv
sudo pacman -Sy --noconfirm --needed firefox-developer-edition
sudo pacman -Sy --noconfirm --needed jre-openjdk
sudo pacman -Sy --noconfirm --needed git-delta
sudo pacman -Sy --noconfirm --needed onefetch
sudo pacman -Sy --noconfirm --needed neofetch
sudo pacman -Sy --noconfirm --needed neovim
sudo pacman -Sy --noconfirm --needed fish

# Install yay
git clone "https://aur.archlinux.org/yay.git"
cd yay && makepkg -si
cd .. && rm -rf yay
$YAY_INSTALLED=true

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Load nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js
nvm install --lts
nvm use --lts

# Install npm packages
npm i -g carbon-now-cli yarn pm2 neovim npm-check-updates git-cz

npm i --prefix ~\.quokka dotenv-quokka-plugin
npm i --prefix ~\.quokka jsdom-quokka-plugin

# Install oh-my-posh
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

# Install NeoVim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# nvim \
# +'autocmd User PackerComplete sleep 100m | write ~/.packer.sync.result | qall' \
# +PackerSync
# cat ~/.packer.sync.result | grep -v 'Press'

# Install ohmyfish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# Install oh-my-fish plugins
fish -c 'omf install nvm'

# Set default shell
chsh -s /bin/fish

# Restore settings files
DOTFILES="$HOME/.dotfiles"
repo="https://github.com/kamack38/linux-dotfiles.git"

git clone --bare $repo $DOTFILES
git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
git --git-dir="$DOTFILES" --work-tree="$HOME" checkout --force
