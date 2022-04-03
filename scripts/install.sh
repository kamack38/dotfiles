#!/usr/bin/env bash

sudo pacman -Sy --noconfirm --needed git
sudo pacman -S --noconfirm --needed base-devel
sudo pacman -S --noconfirm --needed wget
sudo pacman -S --noconfirm --needed ripgrep
sudo pacman -S --noconfirm --needed python
sudo pacman -S --noconfirm --needed snapd
sudo pacman -S --noconfirm --needed bat
sudo pacman -S --noconfirm --needed exa
sudo pacman -S --noconfirm --needed croc
sudo pacman -S --noconfirm --needed yt-dlp
sudo pacman -S --noconfirm --needed ffmpeg
sudo pacman -S --noconfirm --needed mpv
sudo pacman -S --noconfirm --needed firefox-developer-edition
sudo pacman -S --noconfirm --needed jre-openjdk
sudo pacman -S --noconfirm --needed git-delta
sudo pacman -S --noconfirm --needed onefetch
sudo pacman -S --noconfirm --needed neofetch
sudo pacman -S --noconfirm --needed neovim
sudo pacman -S --noconfirm --needed fish
sudo pacman -S --noconfirm --needed github-cli

install_yay() {
    if pacman -Si yay >/dev/null 2>&1; then
        echo "---------------------------"
        echo "Installing yay using pacman"
        echo "---------------------------"
        sudo pacman -Sy --noconfirm --needed yay
    else
        echo "------------------------"
        echo "Building yay from source"
        echo "------------------------"
        sudo pacman -Sy --noconfirm --needed go
        git clone "https://aur.archlinux.org/yay.git"
        cd yay && makepkg -si
        cd .. && rm -rf yay
    fi
}

install_yay

yay -S visual-studio-code-bin
yay -S openrgb
yay -S ff2mpv-native-messaging-host-git

# Fix VSCode
sudo pacman -S gnome-keyring libsecret

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
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish --

# Install oh-my-fish plugins
fish -c 'omf install nvm'

setup_shell() {
    if [ "$(basename -- "$SHELL")" = "fish" ]; then
        return
    fi
    # Set default shell
    sudo chsh -s /bin/fish $USER
}

setup_shell

# Restore settings files
DOTFILES="$HOME/.dotfiles"
repo="https://github.com/kamack38/linux-dotfiles.git"

git clone --bare $repo $DOTFILES
git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
git --git-dir="$DOTFILES" --work-tree="$HOME" checkout --force
