#!/bin/env bash

set -e
# Colours
BLACK=$'\e[0;30m'
WHITE=$'\e[0;37m'
BWHITE=$'\e[1;37m'
RED=$'\e[0;31m'
BLUE=$'\e[0;34m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
NC=$'\e[0m' # No Colour

# Packages
DEV_PROFILE=(
	"jre-openjdk"                 # Java Runtime Environment
	"git-delta"                   # A syntax-highlighting pager for git, diff, and grep output
	"onefetch"                    # Git repository summary cli
	"fastfetch"                   # Like Neofetch, but much faster because written in C
	"github-cli"                  # CLI for GitHub
	"visual-studio-code-bin"      # IDE
	"gnome-keyring"               # Fix vscode
	"libsecret"                   # Fix vscode
	"icu69-bin"                   # Fix live share
	"tealdeer"                    # A fast tldr client in Rust
	"dust"                        # A more intuitive version of du in rust
	"shfmt"                       # A shell parser, formatter, and interpreter for bash
	"ngrok"                       # A tunneling, reverse proxy for developing and understanding networked, HTTP services
	"jq"                          # Command-line JSON processor
	"gnupg"                       # Complete and free implementation of the OpenPGP standard
	"unrar"                       # The RAR uncompression program
	"gdb"                         # The GNU Debugger
	"wakatime"                    # Command line interface used by all WakaTime text editor plugins
	"ueberzug"                    # Command line util which allows to display images in combination with X11
	"bash-completion"             # Programmable completion for the bash shell
	"bash-language-server"        # Bash language server implementation based on Tree Sitter and its grammar for Bash
	"typescript-language-server"  # Language Server Protocol (LSP) implementation for TypeScript using tsserver
	"tailwindcss-language-server" # Tailwind CSS Language Server
	"prettierd"                   # prettier, as a daemon, for ludicrous formatting speed
	"clang"                       # C language family frontend for LLVM
	"typos"                       # Source code spell checker
	"rustcat"                     # A modern port listener and reverse shell
)

NORMAL_PROFILE=(
	"ripgrep"                 # Better grep
	"python"                  # Programming language
	"python-pip"              # Python package manager
	"python-gobject"          # Ui creation (polybar mpris support)
	"flatpak"                 # Flatpak package manager
	"bat"                     # Better cat
	"eza"                     # Better ls
	"croc"                    # File transfer utility
	"mpv"                     # Image/Video player
	"ffmpeg"                  # Audio/Image/Video file converter
	"yt-dlp"                  # Better YouTube downloader
	"neovim"                  # Vim-like text editor
	"fish"                    # New shell
	"fisher"                  # Fish plugin manager
	"oh-my-posh-bin"          # Shell prompt
	"mkinitcpio-colors-git"   # mkinitcpio hook to set VT console colors during early userspace
	"fzf"                     # Fuzzy finder
	"libqalculate"            # Calculator (qalc)
	"cava"                    # Audio visualizer
	"ttf-font-awesome"        # Font Awesome font
	"ttf-firacode-nerd"       # Patched font Fira (Fura) Code from nerd-fonts library
	"ttf-jetbrains-mono-nerd" # Patched font JetBrains Mono from nerd fonts library
	"terminus-font"           # Monospace bitmap font (for X11 and console)
	"playerctl"               # Command-line utility and library for controlling media players
	"mpv-mpris"               # mpv mpris support
	"update-grub"             # Utility for updating grub config
	"btop"                    # System monitor tool
	"reflector"               # Pacman mirror sorter
	"crabz-bin"               # Like pigz, but in Rust
	"garuda-hooks"            # Garuda pacman hooks
	"mpd-mpris"               # An implementation of the MPRIS protocol for MPD.
	"mpd"                     # Flexible, powerful, server-side application for playing music
	"mpc"                     # Minimalist command line interface to MPD
	"ncmpcpp"                 # Almost exact clone of ncmpc with some new features
	"brightnessctl"           # Lightweight brightness control tool
	"sptlrx-bin"              # Timesynced Spotify lyrics in your terminal
	"libfido2"                # Library functionality for FIDO 2.0, including communication with a device over USB
	"yubikey-manager"         # Python library and command line tool for configuring a YubiKey
	"xdg-user-dirs"           # Manages user directories
	"${DEV_PROFILE[@]}"
)

GAMING_PROFILE=(
	"mangohud"              # Hud for showing performance metrics
	"input-devices-support" # Meta package for input devices support
	"piper"                 # Mouse button configurer
	"steam"                 # Game library
	"proton-ge-custom"      # Custom layer for running Windows games on Linux
	"lutris-git"            # Open Gaming Platform
	"wine"                  # A compatibility layer for running Windows programs
)

SOUND_PROFILE=(
	"pipewire"                    # Low-latency audio/video router and processor
	"pipewire-alsa"               # Low-latency audio/video router and processor - ALSA configuration
	"pipewire-jack"               # Low-latency audio/video router and processor - JACK support
	"pipewire-pulse"              # Low-latency audio/video router and processor - PulseAudio replacement
	"pipewire-v4l2"               # Low-latency audio/video router and processor - V4L2 interceptor
	"pipewire-zeroconf"           # Low-latency audio/video router and processor - Zeroconf support
	"gst-plugin-pipewire"         # Multimedia graph framework - pipewire plugin
	"libpulse"                    # A featureful, general-purpose sound server (client library)
	"wireplumber"                 # Session / policy manager implementation for PipeWire
	"sof-firmware"                # Sound Open Firmware
	"realtime-privileges"         # Realtime privileges for users
	"pamixer"                     # Pulseaudio command-line mixer like amixer
	"noise-suppression-for-voice" # A real-time noise suppression plugin for voice
)

VM_PROFILE=(
	"virt-manager-meta"
)

BLUETOOTH_PROFILE=(
	"bluetooth-support" # Metapkg containing needed packages for using Bluetooth
)

RUST_DEV_PROFILE=(
	"rustup" # The Rust toolchain installer
)

DESKTOP_APPS=(
	"sddm"                      # QML based X11 and Wayland display manager
	"ark"                       # Archive Manager
	"dolphin"                   # File Manager
	"partitionmanager"          # Partition Manager
	"gwenview"                  # Image viewer
	"polkit-kde-agent"          # Daemon providing a polkit authentication UI
	"qt5-imageformats"          # Add more image formats (webp)
	"caprine"                   # Messenger app for Linux
	"discord"                   # VoIP and instant messaging social platform
	"firefox-developer-edition" # Web browser for developers
	"ff2mpv-rust"               # Open video in mpv
	"spotify"                   # Music client
	"spicetify-cli"             # Cli for extending spotify
	"kitty-git"                 # GPU accelerated terminal
	"dbus-python"               # Python bindings for DBUS (Polybar ...)
	"desktop-file-utils"        # Command line utilities for working with desktop entries
	"breeze"                    # Artwork, styles and assets for the Breeze visual style for the Plasma Desktop
	"ripdrag-git"               # Drag and drop files to and from the terminal
	"pika-backup"               # Easy to use backup tool to keep your data safe
)

PROFILES=(
	"Gaming"
	"Sound"
	"VM"
	"Bluetooth"
	"Rust Dev"
)

NVIDIA_DRIVERS=(
	"garuda-nvidia-config"
	"garuda-video-linux-config"
	"nvidia-dkms"
	"nvidia-utils"
	"lib32-nvidia-utils"
	"nvidia-settings"
	"vulkan-icd-loader"
	"lib32-vulkan-icd-loader"
)

NVIDIA_MODULES=(
	"nvidia"
	"nvidia_modeset"
	"nvidia_uvm"
	"nvidia_drm"
)

AMD_DRIVERS=(
	"garuda-video-linux-config"
	"lib32-mesa"
	"vulkan-radeon"
	"lib32-vulkan-radeon"
	"vulkan-icd-loader"
	"lib32-vulkan-icd-loader"
)

AMD_MODULES=(
	"amdgpu"
	"radeon"
)

INTEL_DRIVERS=(
	"garuda-video-linux-config"
	"lib32-mesa"
	"vulkan-intel"
	"lib32-vulkan-intel"
	"vulkan-icd-loader"
	"lib32-vulkan-icd-loader"
)

INTEL_MODULES=(
	"intel_agp"
	"i915"
)

FISH_PACKAGES=(
	"jorgebucaran/nvm.fish" # Node version manager
	"jethrokuan/z"          # Z implementation in fish
)

NPM_PACKAGES=(
	"npm"
	"yarn"
	"pm2"
	"neovim"
	"npm-check-updates"
	"git-cz"
)

DESKTOP_ENVIRONMENTS=(
	"KDE"
	"AwesomeWM"
	"Hyprland"
)

CUSTOMIZATION_PACKAGES=(
	"lightly-qt6"             # Bali10050's fork of Lightly (A modern style for qt applications)
	"archcraft-backgrounds"   # Desktop backgrounds
	"fluent-icon-theme-git"   # A Fluent design icon theme
	"fluent-cursor-theme-git" # An x-cursor theme inspired by Qogir theme and based on capitaine-cursors.
)

PLYMOUTH_PACKAGES=(
	"plymouth"                 # A graphical boot splash screen with kernel mode-setting support
	"archcraft-plymouth-theme" # Default plymouth theme for Archcraft
)

RAZER_PACKAGES=(
	"polychromatic-git"  # RGB lighting management front-end application for OpenRazer
	"openrazer-meta-git" # Meta package for installing all required openrazer packages
)

SECURITY_PACKAGES=(
	"lynis"        # Security and system auditing tool to harden Unix/Linux systems
	"rkhunter"     # Checks machines for the presence of rootkits and other unwanted tools
	"libpwquality" # Library for password quality checking and generating random passwords
	"ufw"          # Uncomplicated and easy to use CLI tool for managing a netfilter firewall
)

# Default vars
HELPER="paru"
HELPER_CLONE_PATH="$HOME/.cache/paru/clone"
DOTFILES="$HOME/.dotfiles"
REPO="https://github.com/kamack38/dotfiles"
NEOVIM_CONFIG_DIR="$HOME/.config/nvim"
SPOTIFY_PREFS="$HOME/.config/spotify/prefs"
NODE_VERSION="lts"
TIME_ZONE="Europe/Warsaw" # To get all timezones run `timedatectl list-timezones`
MAIN_LOCALE="en_GB.UTF-8"
SECONDARY_LOCALE="pl_PL.UTF-8"
SPELLCHECK_LOCALES=("${MAIN_LOCALE/_*/}" "${SECONDARY_LOCALE/_*/}")
KB_LAYOUT="pl" # To get all keyboard layouts run `localectl list-keymaps`
MAKEFLAGS="-j$(nproc)"
CURRENT_USER="$USER"

# Root notice
if [ "$(id -u)" = 0 ]; then
	echo "##################################################################"
	echo "This script MUST NOT be run as root user since it makes changes"
	echo "to the \$HOME directory of the \$USER executing this script."
	echo "The \$HOME directory of the root user is, of course, '/root'."
	echo "We don't want to mess around in there. So run this script as a"
	echo "normal user. You will be asked for a sudo password when necessary."
	echo "##################################################################"
	exit 1
fi

# Show greeting
echo "   ___  __    _____ ______  _________  ________"
echo "  |\  \|\  \ |\   _ \  __ \|\_____   \|\   __  \ "
echo "  \ \  \/  /|\ \  \\\\\__\ \  \|_____\  \ \  \|\  \    Kamack38"
echo "   \ \   ___  \ \  \\\\|__| \  \|______  \ \   __  \   ${BLUE}https://twitter.com/kamack38${NC}"
echo "    \ \  \\\\ \  \ \  \    \ \  \| ____\  \ \  \|\  \  https://github.com/kamack38"
echo "     \ \__\\\\ \__\ \__\    \ \__\|\_______\ \_______\ "
echo "      \|__| \|__|\|__|     \|__|\|_______|\|_______|"
echo ""
echo "		${RED}Thank you for using my script! ${NC}"

echo "${BLUE}:: ${BWHITE}Doing a system update, cause stuff may break if it's not the latest version...${NC}"
sudo pacman --noconfirm -Syu

echo "${BLUE}:: ${BWHITE}Installing basic packages...${NC}"
yes | sudo pacman -S --needed iptables-nft
sudo pacman -S --noconfirm --needed base-devel wget git

# Create dirs
echo "${BLUE}:: ${BWHITE}Creating directories...${NC}"
mkdir -p "$NEOVIM_CONFIG_DIR"
mkdir -p "$HOME/.srcs"

# Set time zone and enable time sync
echo "${BLUE}:: ${BWHITE}Setting time zone to ${BLUE}${TIME_ZONE}${BWHITE}...${NC}"
sudo timedatectl set-timezone "${TIME_ZONE}"
sudo timedatectl set-ntp true
sudo hwclock --systohc

# Generate locale
echo "${BLUE}:: ${BWHITE}Generating locales...${NC}"
sudo sed -i '/# Locales enabled by dotfiles install script/,$d' /etc/locale.gen
sudo tee -a /etc/locale.gen >/dev/null <<EOT
#
# Locales enabled by dotfiles install script
en_US.UTF-8 UTF-8
${MAIN_LOCALE} UTF-8
${SECONDARY_LOCALE} UTF-8
EOT
sudo locale-gen

# Set locale
echo "${BLUE}:: ${BWHITE}Setting locales...${NC}"
sudo tee /etc/locale.conf >/dev/null <<EOT
LANG=${MAIN_LOCALE}
LC_ADDRESS=${SECONDARY_LOCALE}
LC_IDENTIFICATION=${SECONDARY_LOCALE}
LC_MEASUREMENT=${SECONDARY_LOCALE}
LC_MONETARY=${SECONDARY_LOCALE}
LC_NAME=${SECONDARY_LOCALE}
LC_NUMERIC=${SECONDARY_LOCALE}
LC_PAPER=${SECONDARY_LOCALE}
LC_TELEPHONE=${SECONDARY_LOCALE}
LC_TIME=${SECONDARY_LOCALE}
EOT

# Reload locale
echo "${BLUE}:: ${BWHITE}Reloading locales${NC}"
unset LANG
source /etc/profile.d/locale.sh

# Set keyboard layout
echo "${BLUE}:: ${BWHITE}Setting keyboard layout to ${GREEN}${KB_LAYOUT}${BWHITE}...${NC}"
sudo localectl set-keymap $KB_LAYOUT

# Add parallel downloading
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

# Enable color
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf

# Enable candy
sudo sed -i 's/^#ILoveCandy/ILoveCandy/' /etc/pacman.conf

# Install helper
if ! command -v $HELPER &>/dev/null; then
	echo "${YELLOW}:: ${BWHITE}It seems that you don't have ${BLUE}$HELPER${BWHITE} installed${NC} -- installing"
	if [ -d "$HELPER_CLONE_PATH/$HELPER" ]; then
		rm -rf "${HELPER_CLONE_PATH}/${HELPER}"
	fi
	mkdir -p "$HELPER_CLONE_PATH"
	git clone https://aur.archlinux.org/$HELPER.git "$HELPER_CLONE_PATH/$HELPER"
	(cd "$HELPER_CLONE_PATH/$HELPER" && makepkg --noconfirm -si)
else
	echo "${GREEN}:: ${BLUE}${HELPER}${BWHITE} is already installed${NC} -- skipping"
fi

# Install dotfiles
if [[ -d "$DOTFILES" && "$(git -C "$DOTFILES" ls-remote --get-url)" == "$REPO"* ]]; then
	echo "${YELLOW}:: ${BLUE}dotfiles${BWHITE} are already installed${NC} -- updating"
	git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
	git --git-dir="$DOTFILES" --work-tree="$HOME" pull --all
else
	echo "${YELLOW}:: ${BWHITE}Cloning ${BLUE}dotfiles${NC} from ${BLUE}${REPO#*//*/}${NC}"
	git clone --bare $REPO "$DOTFILES"
	git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
	git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
	git --git-dir="$DOTFILES" --work-tree="$HOME" checkout --force
fi

# Load XDG variables
echo "${GREEN}:: ${BWHITE}Loading ${BLUE}XDG${BWHITE} paths...${NC}"
while IFS="" read -r p || [ -n "$p" ]; do
	if [[ $p != "#"* && $p != "" ]]; then
		eval "$(echo "$p" | sed 's/DEFAULT=//; s/@/$/g' | awk '{ print "export="$1"=\""$2"\"" }')"
	fi
done <~/.pam_environment

# Add additional repositories
source "$HOME/scripts/repos.sh"
multilib
chaotic_aur
garuda
cachyos
sudo $HELPER -Sy

# Install CPU drivers
proc_type=$(lscpu)
if grep -E "GenuineIntel" <<<"${proc_type}"; then
	echo "${BLUE}:: ${BWHITE}Installing ${BLUE}Intel${BWHITE} microcode...${NC}"
	echo "Installing Intel microcode"
	sudo pacman -S --noconfirm --needed intel-ucode
elif grep -E "AuthenticAMD" <<<"${proc_type}"; then
	echo "${BLUE}:: ${BWHITE}Installing ${BLUE}AMD${BWHITE} microcode...${NC}"
	sudo pacman -S --noconfirm --needed amd-ucode
fi

# Install GPU drivers
VGA_INFO=$(lspci -vnn | grep VGA)
if [[ $VGA_INFO == *"NVIDIA"* ]]; then
	echo "${GREEN}:: ${BWHITE}Installing ${BLUE}NVIDIA${BWHITE} drivers${NC}"
	$HELPER -S --noconfirm --needed --quiet "${NVIDIA_DRIVERS[@]}"

	for i in "${NVIDIA_MODULES[@]}"; do
		if ! grep -q "\b$i\b" /etc/mkinitcpio.conf; then
			sudo sed -i "s,\(MODULES=.*\)\()\),\1 $i\2," /etc/mkinitcpio.conf
		fi
	done

	sudo tee /etc/modprobe.d/nvidia.conf >/dev/null <<EOT
options nouveau modeset=0
EOT
	sudo tee /etc/modprobe.d/blacklist-nvidia-nouveau.conf >/dev/null <<EOT
blacklist nouveau
options nouveau modeset=0
EOT
else
	echo "${YELLOW}:: ${BLUE}NVIDIA${BWHITE} GPU not detected${NC} -- skipping"
fi

if [[ $VGA_INFO == *"AMD"* ]]; then
	echo "${GREEN}:: ${BWHITE}Installing ${BLUE}AMD${BWHITE} drivers${NC}"
	$HELPER -S --noconfirm --needed --quiet "${AMD_DRIVERS[@]}"

	for i in "${AMD_MODULES[@]}"; do
		if ! grep -q "\b$i\b" /etc/mkinitcpio.conf; then
			sudo sed -i "s,\(MODULES=.*\)\()\),\1 $i\2," /etc/mkinitcpio.conf
		fi
	done
else
	echo "${YELLOW}:: ${BLUE}AMD${BWHITE} GPU not detected${NC} -- skipping"
fi

if [[ $VGA_INFO == *"INTEL"* ]]; then
	echo "${GREEN}:: ${BWHITE}Installing ${BLUE}INTEL${BWHITE} drivers${NC}"
	$HELPER -S --noconfirm --needed --quiet "${INTEL_DRIVERS[@]}"

	for i in "${INTEL_MODULES[@]}"; do
		if ! grep -q "\b$i\b" /etc/mkinitcpio.conf; then
			sudo sed -i "s,\(MODULES=.*\)\()\),\1 $i\2," /etc/mkinitcpio.conf
		fi
	done
else
	echo "${YELLOW}:: ${BLUE}INTEL${BWHITE} GPU not detected${NC} -- skipping"
fi

# Install packages
echo "${GREEN}:: ${BWHITE}Installing ${BLUE}default${BWHITE} packages using ${BLUE}${HELPER}${NC}"
$HELPER -S --noconfirm --needed --quiet "${NORMAL_PROFILE[@]}"

# Additional packages
echo "${BLUE}:: ${BWHITE}Which profiles do you want to install?${NC}"
SELECTED_PROFILES=$(printf "%s\n" "${PROFILES[@]}" | fzf --multi --height=20% --layout=reverse --header="Select profiles to install. Use TAB to select multiple." | awk '{print toupper($0)}' | sed 's/ /_/g' || true)

if [[ $SELECTED_PROFILES == *"GAMING"* ]]; then
	echo "${BLUE}:: ${BWHITE}Installing ${BLUE}gaming${BWHITE} packages...${NC}"
	$HELPER -S --noconfirm --needed --quiet "${GAMING_PROFILE[@]}"
fi
if [[ $SELECTED_PROFILES == *"VM"* ]]; then
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}virtual machine${BWHITE} support...${NC}"
	$HELPER -S --noconfirm --needed --quiet "${VM_PROFILE[@]}"

	# Enable services
	sudo systemctl enable --now libvirtd.service

	# Autostart bridge
	sudo virsh net-autostart default
	sudo virsh net-start default
fi
if [[ $SELECTED_PROFILES == *"SOUND"* ]]; then
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}sound${BWHITE} support...${NC}"
	yes | $HELPER -S --needed --quiet "${SOUND_PROFILE[@]}"
	systemctl enable --user pipewire-pulse.service

	# Create realtime group
	getent group "realtime" &>/dev/null || groupadd -r realtime

	# Add all users to group realtime
	echo "${BLUE}:: ${BWHITE}Adding users to realtime group...${NC}"
	for ID in $(grep '/home' /etc/passwd | cut -d ':' -f1); do
		(sudo usermod -aG realtime "$ID")
	done
fi
if [[ $SELECTED_PROFILES == *"BLUETOOTH"* ]]; then
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}bluetooth${BWHITE} support...${NC}"
	$HELPER -S --noconfirm --needed --quiet "${BLUETOOTH_PROFILE[@]}"
fi
if [[ $SELECTED_PROFILES == *"RUST_DEV"* ]]; then
	echo "${BLUE}:: ${BWHITE}Installing rust profile...${NC}"
	yes | $HELPER -S --needed --quiet "${RUST_DEV_PROFILE[@]}"
	rustup install stable
	rustup component add clippy
	rustup component add rustfmt
	rustup component add rust-analyzer
fi

# Install tweaks
TWEAKS=$(echo -e "performance-tweaks\npowersave-tweaks" | fzf --height=20% --layout=reverse || true)

if [[ $TWEAKS != "" ]]; then
	echo "${BLUE}:: ${BWHITE}Installing ${TWEAKS/-/ }...${NC}"
	$HELPER -S --noconfirm --needed --quiet "$TWEAKS"

	if [[ $TWEAKS == "performance-tweaks" ]] && ! grep -q 'mitigations=off' /etc/default/grub; then
		sudo sed -i 's,\(^GRUB_CMDLINE_LINUX_DEFAULT=\".*\)quiet\(.*\"\),\1quiet mitigations=off\2,' /etc/default/grub
	fi
fi

# Install spellchecking
echo "${GREEN}:: ${BWHITE}Installing ${BLUE}spellchecking${BWHITE} and ${BLUE}thesaurus${BWHITE} for ${BLUE}${SPELLCHECK_LOCALES[*]}${BWHITE}...${NC}"
for LOCALE in "${SPELLCHECK_LOCALES[@]}"; do
	$HELPER -S --noconfirm --needed --quiet "aspell-${LOCALE}" "mythes-${LOCALE}"
done

# Install pip packages
echo -e "${GREEN}:: ${BWHITE}Installing ${BLUE}pip${BWHITE} packages${NC}"
pip install --no-warn-script-location --upgrade neovim

# Add .local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Update xdg dirs
xdg-user-dirs-update

# Install fish plugins
echo "${GREEN}:: ${BWHITE}Installing ${BLUE}fish${BWHITE} packages${NC}"
echo "fisher install ${FISH_PACKAGES[*]}" | fish

# Generate completions
gh completion -s fish >"$HOME/.config/fish/completions/gh.fish"

# Install node & npm packages
echo "${GREEN}:: ${BWHITE}Installing ${BLUE}node${BWHITE} (${NODE_VERSION}) & ${BLUE}npm${BWHITE} packages${NC}"
echo "nvm install ${NODE_VERSION} && npm i --location=global" "${NPM_PACKAGES[@]}" | fish

# Enable custom tty colours
sudo tee /etc/vconsole.conf >/dev/null <<EOT
COLOR_0=1e2127
COLOR_1=e06c75
COLOR_2=98c379
COLOR_3=d19a66
COLOR_4=61afef
COLOR_5=c678dd
COLOR_6=56b6c2
COLOR_7=abb2bf
COLOR_8=5c6370
COLOR_9=e06c75
COLOR_10=98c379
COLOR_11=d19a66
COLOR_12=61afef
COLOR_13=c678dd
COLOR_14=56b6c2
COLOR_15=ffffff
FONT=ter-v20b
KEYMAP=${KB_LAYOUT}
EOT

if grep -q "^HOOKS=.*colors.*" /etc/mkinitcpio.conf; then
	if grep -q "^HOOKS=.*systemd.*" /etc/mkinitcpio.conf; then
		sudo sed -i "s,\(^HOOKS=.*\)systemd\(.*\),\1systemd colors\2," "/etc/mkinitcpio.conf"
	else
		sudo sed -i "s,\(^HOOKS=.*\)udev\(.*\),\1udev colors\2," "/etc/mkinitcpio.conf"
	fi
fi

# Set default shell to fish
if [ ! "$(basename -- "$SHELL")" = "fish" ]; then
	echo "${YELLOW}:: ${BWHITE}Setting default shell to ${BLUE}fish${NC}"
	sudo chsh -s /bin/fish "$USER"
fi

# Update submodules
echo "${BLUE}:: ${BWHITE}Updating ${BLUE}submodules${NC}"
git --git-dir="$DOTFILES" --work-tree="$HOME" submodule update --init --remote

# Enable services
echo "${BLUE}:: ${BWHITE}Enabling services...${NC}"
systemctl --user enable mpd.service
systemctl --user enable mpd-mpris.service
systemctl --user enable playerctld.service

# Desktop setup
echo "${BLUE}:: ${BWHITE}Select desktop environments to install...${NC}"
echo "${BLUE}:: ${BWHITE}Use TAB to select more than one.${NC}"
echo "${BLUE}:: ${BWHITE}Press ESCAPE to exit.${NC}"

SELECTED_DE=$(printf "%s\n" "${DESKTOP_ENVIRONMENTS[@]}" | fzf --multi --height=20% --layout=reverse || true)

if [[ "${SELECTED_DE}" != "" ]]; then
	$HELPER -S --noconfirm --needed --quiet "${DESKTOP_APPS[@]}"
	for DE in $SELECTED_DE; do
		DE=$(echo "$DE" | awk '{print tolower($0)}')
		bash "$HOME/scripts/profiles/${DE}.sh"
	done

	# Enable service
	sudo systemctl enable sddm.service

	# Enable spicetify
	if [[ ! -f "$HOME/.config/spicetify/Backup/xpui.spa" ]]; then
		echo "${YELLOW}:: ${BWHITE}Fixing ${BLUE}spicetify${BWHITE}...${NC}"
		sed -i "s,\(prefs_path.*=\).*,\1 $SPOTIFY_PREFS," "$HOME/.config/spicetify/config-xpui.ini"
		echo "${YELLOW}:: ${BWHITE}Run ${BLUE}spicetify backup apply${BWHITE} to apply spicetify...${NC}"
	fi
else
	echo "${YELLOW}:: ${BWHITE}No desktop environment selected${NC} -- skipping"
fi

if [[ $(pacman -Q sddm) ]]; then
	read -rp "${YELLOW}:: ${BWHITE}Do you want to enable automatic login? [y/N]${NC}: " auto_login
	sudo mkdir -p /etc/sddm.conf.d

	if [[ $auto_login == y* ]]; then
		SESSIONS=$(find /usr/share/wayland-sessions/ /usr/share/xsessions/ -type f | sed 's,.*/\(.*\).desktop,\1,')
		echo "${BLUE}:: ${BWHITE}Select session to which you want to be logged in automatically...${NC}"
		SESSION=$(printf "%s\n" "${SESSIONS[@]}" | fzf --height=20% --layout=reverse || true)
		if [[ $SESSION != "" ]]; then
			echo "${BLUE}:: ${BWHITE}Enabling automatic login...${NC}"
			sudo tee /etc/sddm.conf.d/autologin.conf >/dev/null <<EOT
[Autologin]
User=${CURRENT_USER}
Session=${SESSION}
EOT
		else
			echo "${RED}:: ${BHWITE}No session selected${NC} -- skipping"
		fi
	fi
fi

if [[ $(pacman -Q grub) ]]; then
	echo "${BLUE}:: ${BWHITE}Installing plymouth...${NC}"

	# Add archcraft repository
	archcraft
	sudo pacman -Sy
	$HELPER -S --noconfirm --needed --quiet "${PLYMOUTH_PACKAGES[@]}"

	# Set default plymouth theme
	sudo plymouth-set-default-theme -R archcraft

	# Plymouth hook
	if ! grep -q "^HOOKS=.*plymouth.*" /etc/mkinitcpio.conf; then
		echo "${YELLOW}:: ${BWHITE}Adding plymouth hook...${NC}"
		sudo sed -i "s,\(^HOOKS=.*\)udev\(.*\),\1udev plymouth\2," "/etc/mkinitcpio.conf"
	else
		echo "${YELLOW}:: ${BWHITE}plymouth hook already exists${NC} -- skipping"
	fi

	# Update grub config
	sudo sed -i "s,\(GRUB_CMDLINE_LINUX_DEFAULT=\".*\)\(\"\),\1 quiet splash vt.global_cursor_default=0\2," "/etc/default/grub"
	sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

# Create initial ramdisk
sudo mkinitcpio -P

if [[ $(pacman -Q xorg-server) ]]; then
	echo "${YELLOW}:: ${BWHITE}Xorg server detected${NC}"

	echo "${BLUE}:: ${BWHITE}Installing customization packages...${NC}"
	$HELPER -S --noconfirm --needed --quiet "${CUSTOMIZATION_PACKAGES[@]}"

	echo "${BLUE}:: ${BWHITE}Setting keyboard layout...${NC}"
	sudo localectl set-x11-keymap $KB_LAYOUT

	echo "${BLUE}:: ${BWHITE}Setting cursour...${NC}"
	mkdir -p "/usr/share/icons/default"
	sudo tee /usr/share/icons/default/index.theme >/dev/null <<EOT
[Icon Theme]
Inherits=Fluent-cursors
EOT

	echo "${BLUE}:: ${BWHITE}Disabling mouse acceleration...${NC}"
	sudo touch /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
	sudo tee /etc/X11/xorg.conf.d/50-mouse-acceleration.conf >/dev/null <<EOT
Section "InputClass"
    Identifier "My Mouse"
    MatchIsPointer "yes"
    Option "AccelerationProfile" "-1"
    Option "AccelerationScheme" "none"
    Option "AccelSpeed" "-1"
EndSection
EOT
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}libinput${BWHITE} support...${NC}"
	$HELPER -S --noconfirm --needed --quiet libinput
	sudo tee /etc/X11/xorg.conf.d/40-libinput.conf >/dev/null <<EOT
Section "InputClass"
	Identifier "libinput touchpad catchall"
	MatchIsTouchpad "on"
	MatchDevicePath "/dev/input/event*"
	Driver "libinput"
	# Enable left mouse button by tapping
	Option "Tapping" "on"
	Option "TappingButtonMap" "lrm"
   	Option "NaturalScrolling" "on"
	Option "ScrollMethod" "twofinger"
EndSection
EOT
	if [[ $(pacman -Q sddm) ]]; then
		echo "${BLUE}:: ${BWHITE}Installing sddm theme...${NC}"
		$HELPER -S --noconfirm --needed --quiet "sddm-theme-astronaut"

		echo "${BLUE}:: ${BWHITE}Configuring sddm...${NC}"
		sudo tee /etc/sddm.conf.d/30-theme.conf >/dev/null <<EOF
[Theme]
Current=astronaut
CursorTheme=Fluent-cursors
EOF
	fi
fi

# Enable password feedback and other options
sudo mkdir -p /etc/sudoers.d
sudo tee /etc/sudoers.d/01_pwfeedback >/dev/null <<EOT
Defaults env_reset,pwfeedback,insults
EOT
sudo chmod 750 /etc/sudoers.d/01_pwfeedback

read -rp "${BLUE}:: ${BWHITE}Do you want to add additional pacman repositories (archstrike, blackarch, archcraft)? [y/N]${NC}: " repos_script

if [[ $repos_script == y* ]]; then
	archcraft
	chaotic_aur
	blackarch
	archstrike
	dtos
	sudo pacman -Sy
fi

read -rp "${BLUE}:: ${BWHITE}Do you want to run script for asus laptops? [y/N]${NC}: " asus_script

if [[ $asus_script == y* ]]; then
	echo "${BLUE}:: ${BWHITE}Running asus script...${NC}"
	bash "$HOME/scripts/asus.sh"
fi

read -rp "${BLUE}:: ${BWHITE}Do you want to add support for razer hardware? [y/N]${NC}: " razer_script

if [[ $razer_script == y* ]]; then
	echo "${BLUE}:: ${BWHITE}Installing razer drivers & RGB software...${NC}"
	$HELPER -S --noconfirm --needed --quiet "${RAZER_PACKAGES[@]}"

	# Add current user to plugdev group
	sudo gpasswd -a "$CURRENT_USER" plugdev
fi

read -rp "${BLUE}:: ${BWHITE}Do you want to harden your system? [y/N]${NC}: " harden

if [[ $harden == y* ]]; then
	echo "${BLUE}:: ${BWHITE}Installing security packages...${NC}"
	$HELPER -S --noconfirm --needed --quiet "${SECURITY_PACKAGES[@]}"

	SSH_PATH="/etc/ssh/sshd_config"
	if [[ -f "$SSH_PATH" ]]; then
		echo "${BLUE}:: ${BWHITE}Securing ${BLUE}${SSH_PATH}${BWHITE} permissions...${NC}"
		sudo chmod 600 $SSH_PATH
		if [[ ! $(sudo grep '^Protocol 2' $SSH_PATH) ]]; then
			echo "${BLUE}:: ${BWHITE}Disabling SSH protocol v1...${NC}"
			sudo tee -a $SSH_PATH >/dev/null <<EOT
Protocol 2
EOT
		fi
		if [[ ! $(sudo grep '^PermitRootLogin no' $SSH_PATH) ]]; then
			echo "${BLUE}:: ${BWHITE}Disabling root login and passwords...${NC}"
			sudo tee -a $SSH_PATH >/dev/null <<EOT
PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
EOT
		fi
	fi

	echo "${BLUE}:: ${BWHITE}Securing ${BLUE}/boot${BWHITE} permissions...${NC}"
	sudo chmod 700 /boot

	if sudo test -f /boot/grub/grub.cfg; then
		echo "${BLUE}:: ${BWHITE}Securing ${BLUE}/boot/grub/grub.cfg${BWHITE} permissions...${NC}"
		sudo chmod 600 /boot/grub/grub.cfg
	fi

	echo "${BLUE}:: ${BWHITE}Securing ${BLUE}cron${BWHITE} permissions...${NC}"
	sudo chmod 700 -R /etc/cron.*

	if [ -f /etc/cron.deny ]; then
		sudo chmod 600 /etc/cron.deny
	fi

	echo "${BLUE}:: ${BWHITE}Setting up ${BLUE}firewall${BWHITE} using ${BLUE}ufw${BWHITE}...${NC}"
	sudo systemctl disable --now ip6tables.service iptables.service

	sudo ufw default deny incoming
	sudo ufw default allow outgoing
	sudo ufw enable

	echo "${BLUE}:: ${BWHITE}Setting ${BLUE}umask${BWHITE} to 0077...${NC}"
	sudo sed -i 's/umask 022/umask 077/' /etc/profile

	if ! grep "^auth optional pam_faildelay.so" /etc/pam.d/system-login; then
		echo "${BLUE}:: ${BWHITE}Setting ${BLUE}login delay${BWHITE} to 4 seconds...${NC}"
		sudo tee -a /etc/pam.d/system-login >/dev/null <<EOT
auth optional pam_faildelay.so delay=4000000
EOT
	fi

	read -rp "${BLUE}:: ${BWHITE}Do you want to scan your device now? [y/N]${NC}: " SCAN
	if [[ $SCAN == y* ]]; then
		echo "${BLUE}:: ${BWHITE}Running ${BLUE}lynis${BWHITE}...${NC}"
		sudo lynis update info
		sudo lynis audit system
		echo "${BLUE}:: ${BWHITE}Checking for ${BLUE}rootkits${BWHITE}...${NC}"
		sudo rkhunter --propupd
		sudo rkhunter --check --sk
	fi
fi

read -rp "${RED}:: ${BWHITE}Do you want to reboot? [Y/n]${NC}: " reboot_prompt

if [[ ! $reboot_prompt == n* ]]; then
	echo "${YELLOW}:: ${BWHITE}Rebooting...${NC}"
	systemctl reboot
fi
