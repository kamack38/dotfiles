pacman -Sy git python code bat exa croc yt-dlp ffmpeg mpv firefox-developer-edition jre-openjdk git-delta onefetch neofetch neovim fish

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install oh-my-posh
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

# Install NeoVim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

nvim \
+'autocmd User PackerComplete sleep 100m | write ~/.packer.sync.result | qall' \
+PackerSync
cat ~/.packer.sync.result | grep -v 'Press'

# Install ohmyfish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# Install oh-my-fish plugins
omf install nvm

# Install npm packages
npm i -g carbon-now-cli
npm i -g neovim

npm i --prefix ~\.quokka dotenv-quokka-plugin
npm i --prefix ~\.quokka jsdom-quokka-plugin

# Restore settings files
DOTFILES="$HOME/.dotfiles"
repo="https://github.com/kamack38/linux-dotfiles.git"

git clone --bare $repo $DOTFILES
git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
git --git-dir="$DOTFILES" --work-tree="$HOME" checkout
