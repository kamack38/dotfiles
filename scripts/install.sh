#!/bin/bash

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
sudo pacman -S --noconfirm --needed fisher
sudo pacman -S --noconfirm --needed github-cli
sudo pacman -S --noconfirm --needed caprine

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
    yay -Syu
}

install_yay

yay -S visual-studio-code-bin --needed --noconfirm --nodiffmenu --noeditmenu --nouseask --nocleanmenu --noupgrademenu
yay -S ff2mpv-native-messaging-host-git --needed --noconfirm --nodiffmenu --noeditmenu --nouseask --nocleanmenu --noupgrademenu
yay -S oh-my-posh-bin --needed --noconfirm --nodiffmenu --noeditmenu --nouseask --nocleanmenu --noupgrademenu

# Fix VSCode
sudo pacman -S --noconfirm --needed gnome-keyring libsecret

setup_node() {
    # Check if nvm is installed
    if command -v nvm &>/dev/null; then
        echo "You have already installed nvm! Skipping..."
    else
        echo "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

        # Load nvm
        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    fi
    if command -v node &>/dev/null; then
        echo "You have already installed Node.js! Skipping..."
    else
        echo "Installing Node.js..."
        nvm install --lts
        nvm use --lts
    fi
}

setup_node

# Install npm packages
npm i -g carbon-now-cli yarn pm2 neovim npm-check-updates git-cz

npm i --prefix ~\.quokka dotenv-quokka-plugin
npm i --prefix ~\.quokka jsdom-quokka-plugin

# Install NvChad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# nvim \
# +'autocmd User PackerComplete sleep 100m | write ~/.packer.sync.result | qall' \
# +PackerSync
# cat ~/.packer.sync.result | grep -v 'Press'

# Install fish plugins with fisher
setup_fish() {
    fish -c 'fisher install jorgebucaran/nvm.fish'
}

setup_fish && echo "Installation succeeded!"

setup_shell() {
    if [ "$(basename -- "$SHELL")" = "fish" ]; then
        return
    else
        # Set default shell
        sudo chsh -s /bin/fish $USER
    fi
}

setup_shell

# Restore settings files
DOTFILES="$HOME/.dotfiles"
repo="https://github.com/kamack38/linux-dotfiles.git"

git clone --bare $repo $DOTFILES
git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
git --git-dir="$DOTFILES" --work-tree="$HOME" checkout --force

read -p "Do you want to setup NerdFonts? [y/N] " fonts_setup

if [[ $fonts_setup == "y*" ]]; then
    echo "Running script..."
    bash ~/script/fonts.sh
fi

read -p "Do you want to run script for asus laptops? [y/N] " asus_script

if [[ $asus_script == "y*" ]]; then
    echo "Running script..."
    bash ~/script/asus.sh
fi
