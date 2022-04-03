#   ___  __    _____ ______   ________  ________
#  |\  \|\  \ |\   _ \  _   \|\_____  \|\   __  \
#  \ \  \/  /|\ \  \\\__\ \  \|_____\  \ \  \|\  \    Kamack38
#   \ \   ___  \ \  \\|__| \  \|______  \ \   __  \   https://twitter.com/kamack38
#    \ \  \\ \  \ \  \    \ \  \| ____\  \ \  \|\  \  https://github.com/kamack38
#     \ \__\\ \__\ \__\    \ \__\|\_______\ \_______\
#      \|__| \|__|\|__|     \|__|\|_______|\|_______|

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Remove fish default greeting
set fish_greeting

# LS aliases
# alias ll='ls -alF'
alias ll='exa -alF'
alias ls='exa'
# alias la='ls -A'
alias la='exa -a'
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

bind \b 'backward-kill-bigword'

neofetch

oh-my-posh --init --shell fish --config '~/.config/oh-my-posh/kamack.omp.json' | source
