#   ___  __    _____ ______   ________  ________
#  |\  \|\  \ |\   _ \  _   \|\_____  \|\   __  \
#  \ \  \/  /|\ \  \\\__\ \  \|_____\  \ \  \|\  \    Kamack38
#   \ \   ___  \ \  \\|__| \  \|______  \ \   __  \   https://twitter.com/kamack38
#    \ \  \\ \  \ \  \    \ \  \| ____\  \ \  \|\  \  https://github.com/kamack38
#     \ \__\\ \__\ \__\    \ \__\|\_______\ \_______\
#      \|__| \|__|\|__|     \|__|\|_______|\|_______|

# Remove fish default greeting
set fish_greeting

# -------
# Aliases
# -------
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

alias reload="source ~/.config/fish/config.fish"

alias tarnow='tar -acf '
alias untar='tar -xvf '

alias of="onefetch"

export GPG_TTY=(tty)

bind \b backward-kill-bigword

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Paru
function pas
    paru -Slq | fzf --multi --preview 'paru -Si {1}' -q$argv | xargs -ro paru -S # fzf package search prompt
end
function paq
    paru -Qq | fzf --multi --preview 'paru -Si {1}' -q$argv | xargs -ro paru -Qi # fzf package querry prompt
end
function par
    paru -Qq | fzf --multi --preview 'paru -Si {1}' -q$argv | xargs -ro paru -Rns # fzf package querry prompt
end
alias pan="paru --noconfirm"
alias yay="paru"

# ffmpeg
function ffmpeg-extract-audio
    set -l input $argv[1]
    set -l output $argv[2]
    ffmpeg -i "$input" -vn -f mp3 "$output"
end

if status is-interactive && type -q neofetch
    neofetch
end

if status is-interactive && type -q oh-my-posh
    oh-my-posh --init --shell fish --config '~/.config/oh-my-posh/kamack.omp.json' | source
end
