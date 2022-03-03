if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Remove fish default greeting
set --erase fish_greeting

# LS aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# alias ~="cd ~"
alias cls="clear"

neofetch

oh-my-posh --init --shell fish --config '~/.config/ohmyposh/kamack.omp.json' | source
