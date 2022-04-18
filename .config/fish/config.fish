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
set --universal nvm_default_version v16

# Set gpg tty
export GPG_TTY=(tty)

# ------------
# Keybindings
# ------------
bind \b backward-kill-bigword
bind \e\[3\;5~ kill-word

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

alias of="onefetch"

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Paru
function pas --description 'Search and install a package' -a pkg
    command paru -Slq | fzf --multi --preview 'paru -Si {1}' -q$pkg | xargs -ro paru -S --review
end
function paq --description 'Search and show info about a package' -a pkg
    command paru -Qq | fzf --multi --preview 'paru -Si {1}' -q$pkg | xargs -ro paru -Qi
end
function par --description 'Search and remove a package' -a pkg
    command paru -Qq | fzf --multi --preview 'paru -Si {1}' -q$pkg | xargs -ro paru -Rns # fzf package remove prompt
end
alias pan="paru --noconfirm"
alias yay="paru"

# ffmpeg
function ffmpeg-extract-audio -d 'Extracts audio from video'
    set -l input $argv[1]
    set -l output $argv[2]
    command ffmpeg -i "$input" -vn -f mp3 "$output"
end

function fish_greeting
    neofetch
end

if status is-interactive && type -q oh-my-posh
    oh-my-posh --init --shell fish --config '~/.config/oh-my-posh/kamack.omp.json' | source
end
