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
export DIFFPROG="delta"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"
set Z_EXCLUDE "CPlusPlus/*/bin"
# export VISUAL="code"

# Set gpg tty
export GPG_TTY=(tty)

# Enable coloured output
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# ------------
# XDG
# ------------

# XDG fix
alias svn="svn --config-dir \"$XDG_CONFIG_HOME/subversion\""
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"

# ------------
# Keybindings
# ------------
# bind \b backward-kill-bigword
# bind \e\[3\;5~ kill-word
bind \cj history-search-forward
bind \ck history-search-backward
bind \cl forward-char
bind \ch backward-char

# ------------
# Abbreviations
# ------------
function last_history_item
    echo $history[1]
end

function last_history_item_args
    echo $history[1] | cut -f 2- -d " "
end

function last_path
    echo (commandline | rev | cut -f 3 -d " " | rev | xargs -0 dirname --zero)
end

abbr -a !! --position anywhere --function last_history_item # Last command
abbr -a \?\? --position anywhere --function last_history_item_args # Last command without the first word
abbr -a \*\* --position anywhere --function last_path # Last typed path in the commandline. Useful when moving files in the same directory

# ------------
# Aliases
# ------------
# LS aliases
alias ll='eza -alF --git'
alias ls='eza --icons'
alias la='eza -a --icons'
alias lt='eza -T'
alias le='eza -alTL 2'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias cls="clear"

alias logout="loginctl terminate-user $USER"

# Archive aliases
alias tarnow='tar -acf '
alias untar='tar -xvf '
alias gzipnow='tar czf'

# Shorthands
alias of="onefetch"
alias nf="fastfetch"
alias icat="kitty +kitten icat"
alias xterm-kitty="kitty"
alias n="nvim"
alias btc="bluetoothctl"
alias xo="xdg-open"
alias si="su -s /bin/fish"
alias gp="glow -p"

if command -v firefox-developer-edition &>/dev/null
    alias firefox="firefox-developer-edition"
end

# Open files and directories
function r -a path
    if test -f $path
        if path extension $path | string match -raq '^(\.png|\.jpg|\.jpeg|\.webp|\.tiff)$'
            icat $path
        else
            bat $path
        end
    else if test -d $path
        ls $path
    else
        echo "Object does not exist!"
    end
end

# See diff between .pacnew files
function diff-pac -a path
    delta "$path" "$path.pacnew"
end

# Generate passwords
alias passwdgen="date +%s | sha256sum | base64 | head -c 64 ; echo"
alias passgen="strings /dev/urandom | grep -o '[^~`[:space:]]' | head -n 32 | tr -d '\n'"

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
alias docker-clean-all='sudo docker system prune -af'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Python
alias python-gen-deps="pipreqs"

# Sudo edit
alias esudo="sudoedit"

# Pulseaudio
alias multiple-sinks="pactl load-module module-combine-sink sink_name=Simultaneous sink_properties=device.description=CombinedSink slaves=(pactl list short sinks | awk '{print \$2}' | sed -z 's/\\n/,/g; s/,\$/\n/')"

# Hyprland
if test -d /tmp/hypr
    alias hypr-log="bat /tmp/hypr/$(/usr/bin/ls -t /tmp/hypr/ | head -n 2 | tail -n 1)/hyprland.log"
    alias hypr-log-tty="bat /tmp/hypr/$(/usr/bin/ls -t /tmp/hypr/ | head -n 1)/hyprland.log"
end

# Virtual machine
function remove-vm -a vm
    sudo virsh shutdown --domain $vm
    set -l pp (sudo virsh dumpxml --domain $vm | rg 'source file' | cut -d"'" -f 2)
    sudo virsh undefine --domain $vm
    sudo rm -rf $pp
end

# Dolphin
function dolp -a path
    command dolphin $path &>/dev/null & disown
end

# Paru
function pas --description 'Search and install a package' -a pkg
    command paru -Sl --color=never | fzf --with-nth=2 --multi --preview 'paru -Si {1}/{2}' --preview-window wrap -q$pkg | awk '{print $1"/"$2}' | xargs -ro paru -S --review
end
function pasq --description 'Search and install a package' -a pkg
    command paru -Sl --color=never | fzf --with-nth=2 --multi --preview 'paru -Si {1}/{2}' --preview-window wrap -q$pkg | awk '{print $1"/"$2}' | xargs -ro paru -Si
end
function paq --description 'Search and show info about a package' -a pkg
    command paru -Qq --color=never | fzf --multi --preview 'paru -Qi {1}' --preview-window wrap -q$pkg | xargs -ro paru -Qi
end
function par --description 'Search and remove a package' -a pkg
    command paru -Qq --color=never | fzf --multi --preview 'paru -Si {1}' --preview-window wrap -q$pkg | xargs -ro paru -Rns # fzf package remove prompt
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

function fcd -d "cd into favourite your dir"
    cd $(z -l | sed "s#$HOME#~#" | fzf --with-nth=2.. --preview 'eza -alF {2..}' --height 50% --layout=reverse | awk '{print substr($2, 1)}' | sed "s#~#$HOME#")
end

# Typst from stdin
function tm -d 'Shows math expression in terminal' -a math output_file
    set file "/tmp/math1010.typ"
    echo -e "#set page(width: auto, height: auto, margin: 10pt)\n\$\n$math\n\$" >$file
    if test -z "$output_file"
        typst compile -f png "$file" /dev/stdout | icat
    else
        typst compile -f png "$file" "$output_file"
        icat "$output_file"
    end
end

function mp -a output_file
    tm (wl-paste) "$output_file"
end

# Copying and pasting files
function cpf -d 'Copy file contents to clipboard' -a file_name
    cat "$file_name" | wl-copy
end

function psf -d 'Paste clipboard contents to file' -a file_name
    wl-paste >$file_name
end

function ghget -d 'Download file from github'
    set -l url (echo $argv[1] | sed 's/https:\/\/github.com/https:\/\/raw.githubusercontent.com/' | sed 's/blob\///')
    wget $url
end

function rm-except -a file -d 'Remove all files except one'
    rm -rf (ls | grep -v "$file")
end

function fish_greeting
    fastfetch
end

if status is-interactive
    if [ "$TERM" = linux ] && type -q starship
        source (starship init fish --print-full-init | psub)
    else if type -q oh-my-posh
        oh-my-posh init fish --config ~/.config/oh-my-posh/kamack.omp.json | source
    end
end

# pnpm
set -gx PNPM_HOME "/home/kamack38/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

bind \cj history-search-forward
