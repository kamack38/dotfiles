sudo pacman -Syu
sudo pacman -Sy git python code bat exa croc yt-dlp ffmpeg mpv firefox-developer-edition openjdk delta onefetch discord ngrok neovim

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

# Install npm packages
npm i -g carbon-now-cli
npm i -g neovim

npm i --prefix ~\.quokka dotenv-quokka-plugin
npm i --prefix ~\.quokka jsdom-quokka-plugin

# Restore settings files
DOTFILES="$HOME/dotfiles"
repo="https://github.com/kamack38/linux-dotfiles.git"

git clone --bare $repo $DOTFILES
git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
git --git-dir="$DOTFILES" --work-tree="$HOME" checkout
