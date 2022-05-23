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
set -gx EDITOR nvim
fish_add_path -aP $HOME/.local/bin

# Set gpg tty
export GPG_TTY=(tty)
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"
#export XDG_DATA_HOME="$HOME"

# export CARGO_HOME="$XDG_DATA_HOME"/cargo
# export GNUPGHOME="$XDG_DATA_HOME"/gnupg
# export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
# export NVM_DIR="$XDG_DATA_HOME"/nvm
# export WINEPREFIX="$XDG_DATA_HOME"/wine

export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
export KDEHOME="$XDG_CONFIG_HOME/kde"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export HISTFILE="$XDG_CACHE_HOME/bash/history"

# NPM
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_TMP="/tmp"

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

alias makesrcinfo="makepkg --printsrcinfo > .SRCINFO"

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
alias docker-clean-all='sudo docker system prune -af'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Python
alias pip-upgrade="pip install --upgrade pip"

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
        echo "This command requires npm package 'all-the-package-names' to be installed/"
    end
end
function nps --description 'Search and install a local npm package' -a pkg
    if type -q all-the-package-names
        command all-the-package-names | fzf --multi --preview 'npm info {1}' --preview-window wrap -q$pkg | xargs -ro npm install
    else
        echo "This command requires npm package 'all-the-package-names' to be installed/"
    end
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
    cd $(z -l | fzf --with-nth=2.. --preview 'exa -alF {2..}' --height 50% --layout=reverse | awk '{print substr($2, 1)}')
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
