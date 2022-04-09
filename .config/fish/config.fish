#   ___  __    _____ ______   ________  ________
#  |\  \|\  \ |\   _ \  _   \|\_____  \|\   __  \
#  \ \  \/  /|\ \  \\\__\ \  \|_____\  \ \  \|\  \    Kamack38
#   \ \   ___  \ \  \\|__| \  \|______  \ \   __  \   https://twitter.com/kamack38
#    \ \  \\ \  \ \  \    \ \  \| ____\  \ \  \|\  \  https://github.com/kamack38
#     \ \__\\ \__\ \__\    \ \__\|\_______\ \_______\
#      \|__| \|__|\|__|     \|__|\|_______|\|_______|

# Remove fish default greeting
set fish_greeting

# LS aliases
alias ll='exa -alF'
# alias ll='ls -alF'
alias ls='exa'
alias la='exa -a'
# alias la='ls -A'
alias l='ls -CF'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
# alias ~="cd ~"
alias cls="clear"

alias reload="source ~/.config/fish/config.fish"

alias tarnow='tar -acf '
alias untar='tar -xvf '

export GPG_TTY=(tty)

bind \b backward-kill-bigword

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Fzf + paru setup
alias pas="paru -Slq | fzf --multi --preview 'paru -Si {1}' | xargs -ro paru -S"

if status is-interactive && type -q neofetch
    neofetch
end

if status is-interactive && type -q oh-my-posh
    oh-my-posh --init --shell fish --config '~/.config/oh-my-posh/kamack.omp.json' | source
end
