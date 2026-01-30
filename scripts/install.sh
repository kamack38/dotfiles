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
	"fastfetch"                   # Like Neofetch, but much faster because written in C
	"github-cli"                  # CLI for GitHub
	"tealdeer"                    # A fast tldr client in Rust
	"dust"                        # A more intuitive version of du in rust
	"shfmt"                       # A shell parser, formatter, and interpreter for bash
	"deno"                        # A secure runtime for JavaScript and TypeScript (provides a markdown formatter)
	"marksman"                    # Write Markdown with code assist and intelligence in the comfort of your favourite editor.
	"jq"                          # Command-line JSON processor
	"gnupg"                       # Complete and free implementation of the OpenPGP standard
	"unrar"                       # The RAR uncompression program
	"wakatime"                    # Command line interface used by all WakaTime text editor plugins
	"bash-completion"             # Programmable completion for the bash shell
	"bash-language-server"        # Bash language server implementation based on Tree Sitter and its grammar for Bash
	"lua-language-server"         # Lua Language Server coded by Lua
	"typescript-language-server"  # Language Server Protocol (LSP) implementation for TypeScript using tsserver
	"tailwindcss-language-server" # Tailwind CSS Language Server
	"biome"                       # Formatter, linter, and more for Javascript, Typescript, JSON, and CSS
	"clang"                       # C language family frontend for LLVM
	"typos"                       # Source code spell checker
	"base-devel"                  # Basic tools to build Arch Linux packages
)

NORMAL_PROFILE=(
	"ripgrep"                 # Better grep
	"fd"                      # Simple, fast and user-friendly alternative to find
	"man-db"                  # A utility for reading man pages
	"man-pages"               # Linux man pages
	"python"                  # Programming language
	"python-pip"              # Python package manager
	"bat"                     # Better cat
	"less"                    # A terminal based program for viewing text files
	"eza"                     # Better ls
	"croc"                    # File transfer utility
	"mpv"                     # Image/Video player
	"mpv-mpris"               # mpv mpris support
	"mpv-thumbfast-git"       # High-performance on-the-fly thumbnailer for mpv
	"mpv-modernz-git"         # A sleek and modern OSC for mpv
	"ffmpeg"                  # Audio/Image/Video file converter
	"yt-dlp"                  # Better YouTube downloader
	"neovim"                  # Vim-like text editor
	"tree-sitter-cli"         # TS Cli for NeoVim
	"glow"                    # Command-line markdown renderer
	"fish"                    # New shell
	"fisher"                  # Fish plugin manager
	"oh-my-posh-bin"          # Shell prompt
	"starship"                # The cross-shell prompt for astronauts
	"mkinitcpio-colors-git"   # mkinitcpio hook to set VT console colors during early userspace
	"fzf"                     # Fuzzy finder
	"libqalculate"            # Calculator (qalc)
	"cava"                    # Audio visualizer
	"ttf-font-awesome"        # Font Awesome font
	"ttf-firacode-nerd"       # Patched font Fira (Fura) Code from nerd-fonts library
	"ttf-jetbrains-mono-nerd" # Patched font JetBrains Mono from nerd fonts library
	"noto-fonts"              # Google Noto TTF fonts
	"noto-fonts-cjk"          # Google Noto CJK fonts
	"noto-fonts-emoji"        # Google Noto emoji fonts
	"terminus-font"           # Monospace bitmap font (for X11 and console)
	"playerctl"               # Command-line utility and library for controlling media players
	"btop"                    # System monitor tool
	"reflector"               # Pacman mirror sorter
	"wget"                    # Network utility to retrieve files from the Web
	"bc"                      # An arbitrary precision calculator language (required for mpris-noti)
	"mpd-mpris"               # An implementation of the MPRIS protocol for MPD.
	"mpd"                     # Flexible, powerful, server-side application for playing music
	"mpc"                     # Minimalist command line interface to MPD
	"ncmpcpp"                 # Almost exact clone of ncmpc with some new features
	"brightnessctl"           # Lightweight brightness control tool
	"sptlrx-bin"              # Timesynced Spotify lyrics in your terminal
	"libfido2"                # Library functionality for FIDO 2.0, including communication with a device over USB
	"yubikey-manager"         # Python library and command line tool for configuring a YubiKey
	"xdg-user-dirs"           # Manages user directories
	"limine-mkinitcpio-hook"  # Install kernel for the Limine bootloader.
	"limine-snapper-sync"     # The tool syncs Limine snapshot entries with Snapper snapshots.
	"android-udev"            # Udev rules to connect Android devices to your linux box
	"rustic"                  # Fast, encrypted, deduplicated backups powered by Rust (reads and writes restic repos)
	"${DEV_PROFILE[@]}"
)

GAMING_PROFILE=(
	"mangohud"          # Hud for showing performance metrics
	"gamescope"         # SteamOS session compositing window manager
	"gamemode"          # A daemon/lib combo that allows games to request a set of optimisations be temporarily applied to the host OS
	"piper"             # Mouse button configurer
	"steam"             # Game library
	"proton-ge-custom"  # Custom layer for running Windows games on Linux
	"xpadneo-dkms"      # Advanced Linux Driver for Xbox One Wireless Gamepad
	"game-devices-udev" # Udev rules for controllers
	"linuxconsole"      # Set of utilities for joysticks and serial devices
	"iio-sensor-proxy"  # IIO accelerometer sensor to input device proxy
	"lutris-git"        # Open Gaming Platform
	"wine"              # A compatibility layer for running Windows programs
	# "bolt" (If you're using thunderbolt)
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
	"noise-suppression-for-voice" # A real-time noise suppression plugin for voice
)

VM_PROFILE=(
	"virt-manager-meta"
)

BLUETOOTH_PROFILE=(
	"bluetooth-support" # Metapkg containing needed packages for using Bluetooth
)

RUST_DEV_PROFILE=(
	"rustup"    # The Rust toolchain installer
	"taplo-cli" # TOML toolkit written in Rust
)

ANDROID_DEV_PROFILE=(
	"jdk17-openjdk"                    # OpenJDK Java 17 development kit
	"gradle"                           # Powerful build system for the JVM
	"android-sdk"                      # Google Android SDK
	"android-sdk-platform-tools"       # Platform-Tools for Google Android SDK (adb and fastboot)
	"android-sdk-build-tools"          # Build-Tools for Google Android SDK (aapt, aidl, dexdump, dx, llvm-rs-cc)
	"android-sdk-cmdline-tools-latest" # Android SDK Command-line Tools (latest)
	"android-tools"                    # Android platform tools
	"android-studio"                   # The official Android IDE (Stable branch)
	"android-platform"                 # Android SDK Platform, latest API
	"android-emulator"                 # Google Android Emulator
)

TYPST_DEV_PROFILE=(
	"typst"        # A markup-based typesetting system for the sciences
	"typstyle-bin" # Beautiful and reliable typst code formatter
	"tinymist"     # An integrated language service for Typst
	"websocat"     # Command-line client for web sockets (required for typst-preview.nvim)
)

DOCKER_PROFILE=(
	"docker"         # Pack, ship and run any application as a lightweight container
	"docker-compose" # Fast, isolated development environments using Docker
	"lazydocker"     # A simple terminal UI for docker and docker-compose, written in Go with the gocui library.
	"ufw-docker"     # To fix the Docker and UFW security flaw without disabling iptables
)

DESKTOP_APPS=(
	"sddm"                             # QML based X11 and Wayland display manager
	"ark"                              # Archive Manager
	"dolphin"                          # File Manager
	"archlinux-xdg-menu"               # Generate WM menu from xdg files (Fix dolphin no "open with" programs)
	"partitionmanager"                 # Partition Manager
	"gwenview"                         # Image viewer
	"kimageformats"                    # Additional formats for gwenview
	"flatpak"                          # Flatpak package manager
	"polkit-kde-agent"                 # Daemon providing a polkit authentication UI
	"qt6-imageformats"                 # Add more image formats (webp)
	"vesktop"                          # A standalone Electron-based Discord app with Vencord & improved Linux support
	"firefox-developer-edition"        # Web browser for developers
	"ffmpeg4.4"                        # Codecs for Firefox
	"ff2mpv-native-messaging-host-git" # Open video in mpv
	"spotify-launcher"                 # Client for spotify's apt repository in Rust for Arch Linux
	"spicetify-cli"                    # Cli for extending spotify
	"kitty"                            # GPU accelerated terminal
	"desktop-file-utils"               # Command line utilities for working with desktop entries
	"yubico-authenticator-bin"         # Yubico Authenticator for Desktop
	"breeze"                           # Artwork, styles and assets for the Breeze visual style for the Plasma Desktop
	"catppuccin-gtk-theme-macchiato"   # Soothing pastel theme for GTK - Macchiato
	"ripdrag-git"                      # Drag and drop files to and from the terminal
	"btrfs-assistant"                  # An application for managing BTRFS subvolumes and Snapper snapshots
	"flatpak"                          # Linux application sandboxing and distribution framework (formerly xdg-app)
	"darkly-qt6-git"                   # Modern style for KF6/Qt6 applications (fork of Lightly)
	"ttf-ms-fonts"                     # Core TTF Fonts from Microsoft
	"fluent-icon-theme-git"            # A Fluent design icon theme
	"fluent-cursor-theme-git"          # An x-cursor theme inspired by Qogir theme and based on capitaine-cursors.
)

PROFILES=(
	"Gaming"
	"Sound"
	"VM"
	"Bluetooth"
	"Rust Dev"
	"Android Dev"
	"Typst Dev"
	"Docker"
)

NVIDIA_DRIVERS=(
	"nvidia-open-dkms"
	"nvidia-utils"
	"lib32-nvidia-utils"
	"nvidia-settings"
	"vulkan-icd-loader"
	"lib32-vulkan-icd-loader"
	"opencl-nvidia"
	"lib32-opencl-nvidia"
	"libva-nvidia-driver"
)

NVIDIA_MODULES=(
	"nvidia"
	"nvidia_modeset"
	"nvidia_uvm"
	"nvidia_drm"
)

AMD_DRIVERS=(
	"mesa"
	"lib32-mesa"
	"vulkan-radeon"
	"lib32-vulkan-radeon"
)

AMD_MODULES=(
	"amdgpu"
	"radeon"
)

INTEL_DRIVERS=(
	"mesa"
	"lib32-mesa"
	"vulkan-intel"
	"lib32-vulkan-intel"
	"libva-intel-driver"
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
	"pm2"
	"neovim"
)

DESKTOP_ENVIRONMENTS=(
	"Hyprland"
	"KDE"
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
	"lynis"                  # Security and system auditing tool to harden Unix/Linux systems
	"rkhunter"               # Checks machines for the presence of rootkits and other unwanted tools
	"libpwquality"           # Library for password quality checking and generating random passwords
	"ufw"                    # Uncomplicated and easy to use CLI tool for managing a netfilter firewall
	"apparmor"               # Mandatory Access Control (MAC) using Linux Security Module (LSM)
	"cachyos/apparmor.d-git" # Full set of apparmor profiles
)

# Default vars
HELPER="paru"
HELPER_CLONE_PATH="$HOME/.cache/paru/clone"
DOTFILES="$HOME/.dotfiles"
REPO="https://github.com/kamack38/dotfiles"
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
cd "$HOME"

echo "${BLUE}:: ${BWHITE}Installing basic packages...${NC}"
yes | sudo pacman -S --needed iptables-nft
sudo pacman -S --noconfirm --needed git fzf

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
# Any locales placed below will be removed after reinstall
en_US.UTF-8 UTF-8
${MAIN_LOCALE} UTF-8
${SECONDARY_LOCALE} UTF-8
EOT
sudo locale-gen

# Install spellchecking
echo "${GREEN}:: ${BWHITE}Adding ${BLUE}spellchecking${BWHITE} and ${BLUE}thesaurus${BWHITE} for ${BLUE}${SPELLCHECK_LOCALES[*]}${BWHITE}...${NC}"
for LOCALE in "${SPELLCHECK_LOCALES[@]}"; do
	NORMAL_PROFILE+=("aspell-${LOCALE}" "mythes-${LOCALE}")
done
NORMAL_PROFILE+=("hunspell-en_gb" "hunspell-pl")

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
	git --git-dir="$DOTFILES" --work-tree="$HOME" config --local remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
	git --git-dir="$DOTFILES" --work-tree="$HOME" checkout --force
fi

# Load XDG variables
echo "${GREEN}:: ${BWHITE}Loading ${BLUE}XDG${BWHITE} paths...${NC}"
while IFS="" read -r p || [ -n "$p" ]; do
	if [[ $p != "#"* && $p != "" ]]; then
		eval "$(echo "$p" | sed 's/DEFAULT=//; s/@/$/g' | awk '{ print "export="$1"=\""$2"\"" }')"
	fi
done <~/.pam_environment

# Set global env
sudo mkdir -p /etc/environment.d
sudo tee /etc/environment.d/30-editor.conf >/dev/null <<EOT
EDITOR=nvim
EOT

# Add additional repositories
source "$HOME/scripts/repos.sh"
multilib
chaotic_aur
garuda
cachyos
sudo pacman -Sy

# Install helper
if ! command -v $HELPER &>/dev/null; then
	echo "${YELLOW}:: ${BWHITE}It seems that you don't have ${BLUE}$HELPER${BWHITE} installed${NC} -- installing"
	sudo pacman -S --noconfirm $HELPER
else
	echo "${GREEN}:: ${BLUE}${HELPER}${BWHITE} is already installed${NC} -- skipping"
fi

DRIVERS=()

# Install CPU drivers
proc_type=$(lscpu)
if grep -E "GenuineIntel" <<<"${proc_type}"; then
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}Intel${BWHITE} microcode...${NC}"
	DRIVERS+=("intel-ucode")
elif grep -E "AuthenticAMD" <<<"${proc_type}"; then
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}AMD${BWHITE} microcode...${NC}"
	DRIVERS+=("amd-ucode")
fi

# Install GPU drivers
VGA_INFO=$(lspci -vnn | grep VGA)
if [[ $VGA_INFO == *"NVIDIA"* ]]; then
	echo "${GREEN}:: ${BWHITE}Adding ${BLUE}NVIDIA${BWHITE} drivers...${NC}"
	DRIVERS+=("${NVIDIA_DRIVERS[@]}")

	for i in "${NVIDIA_MODULES[@]}"; do
		if ! grep -q "\b$i\b" /etc/mkinitcpio.conf; then
			sudo sed -i "s,\(MODULES=.*\)\()\),\1 $i\2," /etc/mkinitcpio.conf
		fi
	done
else
	echo "${YELLOW}:: ${BLUE}NVIDIA${BWHITE} GPU not detected${NC} -- skipping"
fi

if [[ $VGA_INFO == *"AMD"* ]]; then
	echo "${GREEN}:: ${BWHITE}Adding ${BLUE}AMD${BWHITE} drivers...${NC}"
	DRIVERS+=("${AMD_DRIVERS[@]}")

	for i in "${AMD_MODULES[@]}"; do
		if ! grep -q "\b$i\b" /etc/mkinitcpio.conf; then
			sudo sed -i "s,\(MODULES=.*\)\()\),\1 $i\2," /etc/mkinitcpio.conf
		fi
	done
else
	echo "${YELLOW}:: ${BLUE}AMD${BWHITE} GPU not detected${NC} -- skipping"
fi

if [[ $VGA_INFO == *"INTEL"* ]]; then
	echo "${GREEN}:: ${BWHITE}Adding ${BLUE}INTEL${BWHITE} drivers...${NC}"
	DRIVERS+=("${INTEL_DRIVERS[@]}")

	for i in "${INTEL_MODULES[@]}"; do
		if ! grep -q "\b$i\b" /etc/mkinitcpio.conf; then
			sudo sed -i "s,\(MODULES=.*\)\()\),\1 $i\2," /etc/mkinitcpio.conf
		fi
	done
else
	echo "${YELLOW}:: ${BLUE}INTEL${BWHITE} GPU not detected${NC} -- skipping"
fi

NORMAL_PROFILE+=("${DRIVERS[@]}")

# Select profiles
echo "${BLUE}:: ${BWHITE}Which profiles do you want to install?${NC}"
SELECTED_PROFILES=$(printf "%s\n" "${PROFILES[@]}" | fzf --multi --height=20% --layout=reverse --header="Select profiles to install. Use TAB to select multiple." | awk '{print toupper($0)}' | sed 's/ /_/g' || true)

PROFILE_PACKAGES=()
while IFS=\n read -r PROFILE_NAME; do
	eval "PROFILE_PACKAGES+=(\"\${${PROFILE_NAME}_PROFILE[@]}\")"
done <<<"$SELECTED_PROFILES"
NORMAL_PROFILE+=("${PROFILE_PACKAGES[@]}")

# Remove conflicts
if [[ $(pacman -Qq jack2 2>/dev/null) ]]; then
	echo "${YELLOW}:: ${BWHITE}Removing ${BLUE}jack2${BWHITE} package...${NC}"
	sudo pacman -Rdd --noconfirm jack2
fi

# Must be installed separately since it may be required by some packages
if [[ $SELECTED_PROFILES == *"RUST_DEV"* ]]; then
	echo "${BLUE}:: ${BWHITE}Installing rust profile...${NC}"
	if [[ $(pacman -Qq rust 2>/dev/null) == "rust" ]]; then
		echo "${YELLOW}:: ${BWHITE}Removing ${BLUE}rust${BWHITE} package...${NC}"
		sudo pacman -Rdd --noconfirm rust
	fi
	$HELPER -S --needed --quiet --noconfirm "${RUST_DEV_PROFILE[@]}"
	rustup install stable
	rustup component add clippy
	rustup component add rustfmt
	rustup component add rust-analyzer
fi

if [[ $SELECTED_PROFILES == *"DOCKER"* && $VGA_INFO == *"NVIDIA"* ]]; then
	echo "${GREEN}:: ${BLUE}NVIDIA${BWHITE} GPU detected! Adding nvidia toolkit...${NC}"
	DOCKER_PROFILE+=("nvidia-container-toolkit")

	read -rp "${YELLOW}:: ${BWHITE}Do you want to install ${BLUE}cuda${BHWITE} packages? [y/N]${NC}: " cuda_packages
	if [ $cuda_packages == y* ]; then
		DOCKER_PROFILE+=("cuda" "cudnn")
	fi
fi

# Install packages
echo "${BLUE}:: ${BWHITE}The selected profiles are: ${BLUE}$(echo $SELECTED_PROFILES | sed 's/ /, /g')${BWHITE}.${NC}"
echo "${GREEN}:: ${BWHITE}Installing ${BLUE}default${BWHITE} packages, ${BLUE}drivers${BWHITE} and ${BLUE}selected profiles${BWHITE} using ${BLUE}${HELPER}${NC}"
$HELPER -S --noconfirm --needed --quiet "${NORMAL_PROFILE[@]}"

if [[ $VGA_INFO == *"NVIDIA"* ]]; then
	echo "${GREEN}:: ${BWHITE}Enabling ${BLUE}NVIDIA${BWHITE} services...${NC}"
	sudo systemctl enable nvidia-suspend.service nvidia-hibernate.service nvidia-resume.service
fi

if [[ $SELECTED_PROFILES == *"GAMING"* ]]; then
	echo "${BLUE}:: ${BWHITE}Configuring ${BLUE}gaming${BWHITE} support...${NC}"
	# Create a Big Picture session
	sudo tee /usr/share/wayland-sessions/steam-big-picture.desktop >/dev/null <<EOT
[Desktop Entry]
Name=Steam Big Picture Mode
Comment=Start Steam in Big Picture Mode
Exec=/usr/bin/gamescope -e -- /usr/bin/steam -tenfoot
Type=Application
EOT

	# Add input and video groups
	getent group "input" &>/dev/null || sudo groupadd -r input -g 97
	getent group "video" &>/dev/null || sudo groupadd -r video -g 91
	sudo usermod -a -G input "$USER"
	sudo usermod -a -G video "$USER"
fi
if [[ $SELECTED_PROFILES == *"VM"* ]]; then
	echo "${BLUE}:: ${BWHITE}Configuring ${BLUE}virtual machine${BWHITE} support...${NC}"
	# Enable services (only the socket)
	sudo systemctl is-active libvirtd.service >/dev/null || systemctl disable libvirtd.service
	sudo systemctl enable --now libvirtd.socket
	sudo systemctl enable --now virtlogd.socket
	sudo systemctl enable --now virtlockd.socket

	# Autostart bridge
	sudo virsh net-autostart default

	# Fix permissions
	sudo mkdir -p /var/lib/libvirt/
	sudo chown -R :libvirt /var/lib/libvirt
	sudo chmod -R g=u /var/lib/libvirt
fi
if [[ $SELECTED_PROFILES == *"SOUND"* ]]; then
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}sound${BWHITE} support...${NC}"
	systemctl enable --user pipewire-pulse.service

	# Create realtime group
	getent group "realtime" &>/dev/null || groupadd -r realtime

	# Add all users to group realtime
	echo "${BLUE}:: ${BWHITE}Adding users to realtime group...${NC}"
	for ID in $(grep '/home' /etc/passwd | cut -d ':' -f1); do
		(sudo usermod -aG realtime "$ID")
	done
fi
if [[ $SELECTED_PROFILES == *"ANDROID_DEV"* ]]; then
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}android dev${BWHITE} support...${NC}"

	# Add current user to the android group
	getent group "android" &>/dev/null || groupadd -r android
	sudo usermod -aG android "$CURRENT_USER"

	# Fix permissions
	sudo chown -R root:android /opt/android-sdk
	sudo chmod -R g=u /opt/android-sdk
fi
if [[ $SELECTED_PROFILES == *"DOCKER"* ]]; then
	echo "${BLUE}:: ${BWHITE}Configuring ${BLUE}Docker${BWHITE} profile...${NC}"

	# Enable services
	sudo systemctl enable docker.socket
	sudo usermod -a -G docker "$USER"
fi

# Create snapper config
sudo mkdir -p /etc/snapper/config-templates
sudo tee /etc/snapper/config-templates/snapper-root <<EOF
# subvolume to snapshot
SUBVOLUME="/"

# filesystem type
FSTYPE="btrfs"

# btrfs qgroup for space aware cleanup algorithms
QGROUP=""

# fraction or absolute size of the filesystems space the snapshots may use
SPACE_LIMIT="0.5"

# fraction or absolute size of the filesystems space that should be free
FREE_LIMIT="0.2"

# users and groups allowed to work with config
ALLOW_USERS=""
ALLOW_GROUPS=""

# sync users and groups from ALLOW_USERS and ALLOW_GROUPS to .snapshots
# directory
SYNC_ACL="no"

# start comparing pre- and post-snapshot in background after creating
# post-snapshot
BACKGROUND_COMPARISON="yes"

# run daily number cleanup
NUMBER_CLEANUP="yes"

# limit for number cleanup
NUMBER_MIN_AGE="3600"
NUMBER_LIMIT="8"
NUMBER_LIMIT_IMPORTANT="5"

# create hourly snapshots
TIMELINE_CREATE="no"

# cleanup hourly snapshots after some time
TIMELINE_CLEANUP="yes"

# limits for timeline cleanup
TIMELINE_MIN_AGE="1800"
TIMELINE_LIMIT_HOURLY="5"
TIMELINE_LIMIT_DAILY="7"
TIMELINE_LIMIT_WEEKLY="0"
TIMELINE_LIMIT_MONTHLY="0"
TIMELINE_LIMIT_YEARLY="0"

# cleanup empty pre-post-pairs
EMPTY_PRE_POST_CLEANUP="yes"

# limits for empty pre-post-pair cleanup
EMPTY_PRE_POST_MIN_AGE="1800"
EOF

systemctl enable --now snapper-cleanup.timer

# Workaround if script is run inside chroot
if [ "$(stat -c %d:%i /)" != "$(stat -c %d:%i /proc/1/root/.)" ]; then
	/usr/bin/snapper --no-dbus -c root create-config --template snapper-root /
else
	/usr/bin/snapper -c root create-config --template snapper-root /
fi

# Add .local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Update xdg dirs
xdg-user-dirs-update --force

# Update tealdeer cache
tldr --update

# Create mpd dirs so it doesn't crash
mkdir -p $HOME/Music/playlists $HOME/.cache/mpd $HOME/.local/share/mpd $HOME/.local/state/mpd

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

if ! grep -q "^HOOKS=.*colors.*" /etc/mkinitcpio.conf; then
	if grep -q "^HOOKS=.*systemd.*" /etc/mkinitcpio.conf; then
		sudo sed -i "s,\(^HOOKS=.*\)systemd\(.*\),\1systemd sd-colors\2," "/etc/mkinitcpio.conf"
	else
		sudo sed -i "s,\(^HOOKS=.*\)udev\(.*\),\1udev colors\2," "/etc/mkinitcpio.conf"
	fi
fi

# Set default shell to fish
if [ ! "$(basename -- "$SHELL")" = "fish" ]; then
	echo "${YELLOW}:: ${BWHITE}Setting default shell to ${BLUE}fish${NC}"
	sudo chsh -s /usr/bin/fish "$USER"
fi

# Enable services
echo "${BLUE}:: ${BWHITE}Enabling services...${NC}"
sudo systemctl enable pcscd.socket
systemctl --user enable mpd.service
systemctl --user enable mpd-mpris.service
systemctl --user enable playerctld.service

# Desktop setup
echo "${BLUE}:: ${BWHITE}Select desktop environments to install...${NC}"
echo "${BLUE}:: ${BWHITE}Use TAB to select more than one.${NC}"
echo "${BLUE}:: ${BWHITE}Press ESCAPE to exit.${NC}"

SELECTED_DE=$(printf "%s\n" "${DESKTOP_ENVIRONMENTS[@]}" | fzf --multi --height=20% --layout=reverse || true)

if [[ "${SELECTED_DE}" != "" || $(pacman -Q sddm) ]]; then
	$HELPER -S --noconfirm --needed --quiet "${DESKTOP_APPS[@]}"
	for DE in $SELECTED_DE; do
		DE=$(echo "$DE" | awk '{print tolower($0)}')
		bash "$HOME/scripts/profiles/${DE}.sh"
	done

	# Symlink Firefox
	sudo ln -s /usr/bin/firefox-developer-edition /usr/bin/firefox || :

	# Enable service
	sudo systemctl enable sddm.service

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

	echo "${BLUE}:: ${BWHITE}Installing sddm theme...${NC}"
	$HELPER -S --noconfirm --needed --quiet "sddm-theme-greenleaf"

	echo "${BLUE}:: ${BWHITE}Configuring sddm...${NC}"
	sudo mkdir -p /etc/sddm.conf.d
	sudo tee /etc/sddm.conf.d/30-theme.conf >/dev/null <<EOF
[Theme]
Current=greenleaf
CursorTheme=Fluent-cursors
EOF
else
	echo "${YELLOW}:: ${BWHITE}No desktop environment selected${NC} -- skipping"
fi

if [[ $(pacman -Q sddm) ]]; then
	read -rp "${YELLOW}:: ${BWHITE}Do you want to enable automatic login? [y/N]${NC}: " auto_login

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

# Disable watchdog
echo "${BLUE}:: ${BWHITE}Disabling watchdog...${NC}"
sudo tee /etc/limine-entry-tool.d/20-disable-watchdog.conf >/dev/null <<EOT
KERNEL_CMDLINE[default]+="nowatchdog"
EOT
sudo tee /etc/modprobe.d/blacklist.conf >/dev/null <<EOF
# Blacklist the Intel TCO Watchdog/Timer module
blacklist iTCO_wdt

# Blacklist the AMD SP5100 TCO Watchdog/Timer module (Required for Ryzen cpus)
blacklist sp5100_tco
EOF

# Enable password feedback and other options
sudo mkdir -p /etc/sudoers.d
sudo tee /etc/sudoers.d/01_pwfeedback >/dev/null <<EOT
Defaults env_reset,pwfeedback,insults
EOT
sudo chmod 750 /etc/sudoers.d/01_pwfeedback

# Load ~/.pam_environment on login
if ! grep -q "session.*include.*environment" /etc/pam.d/system-login; then
	sudo tee -a /etc/pam.d/system-login >/dev/null <<EOT
session    include    environment
EOT
fi
sudo tee /etc/pam.d/environment >/dev/null <<EOT
#%PAM-1.0

session    required   pam_env.so readenv=1 user_readenv=1
EOT

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

	SSH_PATH="/etc/ssh/sshd_config.d"
	echo "${BLUE}:: ${BWHITE}Securing ${BLUE}${SSH_PATH}${BWHITE} permissions...${NC}"
	sudo mkdir -p $SSH_PATH
	sudo touch "/etc/ssh/ssh_config"
	sudo chmod 600 "/etc/ssh/ssh_config"
	sudo chmod 600 -R $SSH_PATH

	echo "${BLUE}:: ${BWHITE}Disabling SSH protocol v1...${NC}"
	sudo tee ${SSH_PATH}/99-protocol.conf >/dev/null <<EOT
# Enable only protocol v2
Protocol 2
EOT
	echo "${BLUE}:: ${BWHITE}Disabling root login and passwords...${NC}"
	sudo tee ${SSH_PATH}/99-disable-root-login.conf >/dev/null <<EOT
PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
EOT

	echo "${BLUE}:: ${BWHITE}Securing ${BLUE}/boot${BWHITE} permissions...${NC}"
	sudo chmod 700 /boot

	if sudo test -f /boot/limine.conf; then
		echo "${BLUE}:: ${BWHITE}Securing ${BLUE}/boot/limine.conf${BWHITE} permissions...${NC}"
		sudo chmod 600 /boot/limine.conf
	fi

	echo "${BLUE}:: ${BWHITE}Securing ${BLUE}cron${BWHITE} permissions...${NC}"
	sudo chmod 700 -R /etc/cron.*

	if [ -f /etc/cron.deny ]; then
		sudo chmod 600 /etc/cron.deny
	fi

	echo "${BLUE}:: ${BWHITE}Securing ${BLUE}gpg${BWHITE} permissions...${NC}"
	sudo chmod -R og= $HOME/.local/share/gnupg

	echo "${BLUE}:: ${BWHITE}Setting up ${BLUE}firewall${BWHITE} using ${BLUE}ufw${BWHITE}...${NC}"
	sudo systemctl disable --now ip6tables.service iptables.service

	sudo ufw default deny incoming
	sudo ufw default allow outgoing
	sudo ufw --force enable
	sudo systemctl enable ufw

	if [[ $SELECTED_PROFILES == *"DOCKER"* ]]; then
		sudo ufw-docker install
		sudo ufw reload
	fi

	echo "${BLUE}:: ${BWHITE}Enabling ${BLUE}AppArmor${BWHITE} rules...${NC}"
	sudo systemctl enable apparmor.service
	sudo sed -i 's/^#write-cache/write-cache/' /etc/apparmor/parser.conf
	sudo sed -i 's/^#Optimize=compress-fast/Optimize=compress-fast/' /etc/apparmor/parser.conf
	sudo tee /etc/limine-entry-tool.d/30-apparmor.conf >/dev/null <<EOT
KERNEL_CMDLINE[default]+="lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
EOT

	echo "${BLUE}:: ${BWHITE}Setting ${BLUE}umask${BWHITE} to 0077...${NC}"
	sudo sed -i 's/UMASK\t\t022/UMASK\t\t027/' /etc/login.defs

	echo "${BLUE}:: ${BWHITE}Setting ${BLUE}login delay${BWHITE} to 4 seconds...${NC}"
	sudo tee -a /etc/pam.d/system-login >/dev/null <<EOT
auth optional pam_faildelay.so delay=4000000
EOT

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

# Create initial ramdisk
sudo limine-mkinitcpio

read -rp "${RED}:: ${BWHITE}Do you want to reboot? [Y/n]${NC}: " reboot_prompt

if [[ ! $reboot_prompt == n* ]]; then
	echo "${YELLOW}:: ${BWHITE}Rebooting...${NC}"
	systemctl reboot
fi
