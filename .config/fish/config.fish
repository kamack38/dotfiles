#   ___  __    _____ ______   ________  ________
#  |\  \|\  \ |\   _ \  _   \|\_____  \|\   __  \
#  \ \  \/  /|\ \  \\\__\ \  \|_____\  \ \  \|\  \    Kamack38
#   \ \   ___  \ \  \\|__| \  \|______  \ \   __  \   https://twitter.com/kamack38
#    \ \  \\ \  \ \  \    \ \  \| ____\  \ \  \|\  \  https://github.com/kamack38
#     \ \__\\ \__\ \__\    \ \__\|\_______\ \_______\
#      \|__| \|__|\|__|     \|__|\|_______|\|_______|

# ------------
# Envs
# ------------
# Set default node version
set --universal nvm_default_version lts
export PATH="$PATH:$HOME/.local/bin/:$HOME/.local/share/cargo/bin"
export DIFFPROG="delta"
export EDITOR="nvim"
# export VISUAL="code"

# Set gpg tty
export GPG_TTY=(tty)

# Enable colored output
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Qt theme 
export QT_QPA_PLATFORMTHEME="kde"

# ------------
# XDG
# ------------
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Data
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export TS_NODE_HISTORY="$XDG_DATA_HOME/ts_node_repl_history"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant
export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME/vagrant/aliases"
export GOPATH="$XDG_DATA_HOME/go"

# Config
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
export KDEHOME="$XDG_CONFIG_HOME/kde"
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export FFMPEG_DATADIR="$XDG_CONFIG_HOME/ffmpeg"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

# Cache
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export HISTFILE="$XDG_CACHE_HOME/bash/history"

# NPM
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/.npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"

# XDG fix
alias svn="svn --config-dir \"$XDG_CONFIG_HOME/subversion\""
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"

# ------------
# Keybindings
# ------------
# bind \b backward-kill-bigword
# bind \e\[3\;5~ kill-word

# ------------
# Aliases
# ------------
# LS aliases
alias ll='exa -alF'
alias ls='exa'
alias la='exa -a'
alias lt='exa -T'
alias le='exa -alTL 2'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias cls="clear"

# Reload aliases
alias reload="source ~/.config/fish/config.fish"
alias udev-reload="sudo udevadm control --reload-rules && sudo udevadm trigger"
alias gpg-reload="gpg-connect-agent reloadagent /bye"
alias systemctl-reload="systemctl daemon-reload"

alias tarnow='tar -acf '
alias untar='tar -xvf '
alias gzipnow='tar czf'

alias of="onefetch"
alias icat="kitty +kitten icat"
alias xterm-kitty="kitty"

if command -v firefox-developer-edition &>/dev/null
    alias firefox="firefox-developer-edition"
end

alias makesrcinfo="makepkg --printsrcinfo > .SRCINFO"

alias passwdgen="date +%s | sha256sum | base64 | head -c 64 ; echo"

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
alias docker-clean-all='sudo docker system prune -af'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Python
alias pip-upgrade="pip install --upgrade pip"
alias python-gen-deps="pipreqs"

# Sudo edit
alias esudo="sudoedit"

# Paru
function pas --description 'Search and install a package' -a pkg
    command paru -Sl | fzf --with-nth=2 --multi --preview 'paru -Si {1}/{2}' --preview-window wrap -q$pkg | awk '{print $1"/"$2}' | xargs -ro paru -S --review
end
function pasq --description 'Search and install a package' -a pkg
    command paru -Sl | fzf --with-nth=2 --multi --preview 'paru -Si {1}/{2}' --preview-window wrap -q$pkg | awk '{print $1"/"$2}' | xargs -ro paru -Si
end
function paq --description 'Search and show info about a package' -a pkg
    command paru -Qq | fzf --multi --preview 'paru -Si {1}' --preview-window wrap -q$pkg | xargs -ro paru -Qi
end
function par --description 'Search and remove a package' -a pkg
    command paru -Qq | fzf --multi --preview 'paru -Si {1}' --preview-window wrap -q$pkg | xargs -ro paru -Rns # fzf package remove prompt
end
alias paru-clean-cache="paru -Sc --noconfirm"
alias pan="paru --noconfirm"
alias yay="paru"
alias refresh-mirrorlist="sudo reflector --latest 200 --sort rate --save /etc/pacman.d/mirrorlist --threads 10 -p https"

# Flatpak
function flat --description 'Search for flatpak packages' -a pkg
    command flatpak remote-ls --columns=application,origin,name | fzf --multi --with-nth=3.. --preview 'flatpak remote-info {2} {1}' --preview-window wrap -q$pkg | xargs -ro flatpak install # fzf package install prompt
end

# Bottles
if ! command -v bottles-cli
    function bottles-cli
        flatpak run --command=bottles-cli com.usebottles.bottles
    end
end

# Npm
function npg --description 'Search and install a global npm package' -a pkg
    if type -q all-the-package-names
        command all-the-package-names | fzf --multi --preview 'npm info {1}' --preview-window wrap -q$pkg | xargs -ro npm install -g
    else
        echo "This command requires a global npm package 'all-the-package-names' to be installed"
    end
end
function nps --description 'Search and install a local npm package' -a pkg
    if type -q all-the-package-names
        command all-the-package-names | fzf --multi --preview 'npm info {1}' --preview-window wrap -q$pkg | xargs -ro npm install
    else
        echo "This command requires a global npm package 'all-the-package-names' to be installed"
    end
end

# Yarn
function yas --description 'Search and install a local yarn package'
    if type -q all-the-package-names
        command all-the-package-names | fzf --multi --preview 'npm info {1}' --preview-window wrap -q$pkg | xargs -ro yarn add $argv
    else
        echo "This command requires npm package 'all-the-package-names' to be installed/"
    end
end

# Nerd fonts
# converted from https://code.envrm.info/src/nerdfonts
function nfs --description 'Search nerdfonts gylphs' -a search_term
    set URL "https://nerdfonts.com/cheat-sheet"
    set ICONS 1
    set PAGE "$(curl -s -q -L $URL | grep '<div class="codepoint">[^<]*</div>')"
    echo "$PAGE" | sed 's/^.*<div class="class-name">//g; s/<\/div><div class="codepoint">/ /; s/<\/div>//' | fzf --with-nth=1 --preview "printf '\u{2}'"
end

# Visual Studio Code
function vsr -d "List recently opened files with vscode" -a serach
    set -l vscode_path "$HOME/.config/Code"
    set -l grep

    if type -q rg
        set grep rg -o --no-line-number
    else
        set grep grep -o
    end

    set -l selected (\
          $grep '"path": "/.*[^/]"' "$vscode_path/User/globalStorage/storage.json" \
          | string replace -a '"path": ' '' \
          | string trim -c '"'\
          | fzf --exit-0 --height 50% --layout=reverse -q$serach --preview 'if test -f {}; if begin [ $(string split -r -m1 . $(basename -- {}))[2] = "code-workspace" ]; and type -q as-tree; and type -q jq; end; cat {} | jq \'.folders[] .path\' | as-tree; else; bat --paging=never --color=always --style=plain {}; end; else; if test -d {}; exa {}; else; echo -e \'\033[0;31mDELETED\033[0m\'; end; end' )

    [ -n "$selected" ]; and code "$selected"
end

function fcd -d "cd into favourite your dir"
    cd $(z -l | sed "s#/home/$USER#~#" | fzf --with-nth=2.. --preview 'exa -alF {2..}' --height 50% --layout=reverse | awk '{print substr($2, 1)}')
end

# ffmpeg
function ffmpeg-extract-audio -d 'Extracts audio from video'
    set -l input $argv[1]
    set -l output $argv[2]
    command ffmpeg -i "$input" -vn -f mp3 "$output"
end

function ghget -d 'Download file from github'
    set -l url (echo $argv[1] | sed 's/https:\/\/github.com/https:\/\/raw.githubusercontent.com/' | sed 's/blob\///')
    wget $url
end

function fish_greeting
    neofetch
end

if status is-interactive && type -q oh-my-posh
    oh-my-posh --init --shell fish --config '~/.config/oh-my-posh/kamack.omp.json' | source
end
