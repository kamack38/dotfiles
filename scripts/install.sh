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
	"jre-openjdk"                # Java Runtime Environment
	"git-delta"                  # A syntax-highlighting pager for git, diff, and grep output
	"onefetch"                   # Git repository summary cli
	"neofetch-git"               # A command-line system information tool
	"github-cli"                 # CLI for GitHub
	"visual-studio-code-bin"     # IDE
	"gnome-keyring"              # Fix vscode
	"libsecret"                  # Fix vscode
	"icu69-bin"                  # Fix live share
	"tldr"                       # Collaborative cheatsheets for console commands
	"dust"                       # A more intuitive version of du in rust
	"shfmt"                      # A shell parser, formatter, and interpreter for bash
	"ngrok"                      # A tunneling, reverse proxy for developing and understanding networked, HTTP services
	"jq"                         # Command-line JSON processor
	"gnupg"                      # Complete and free implementation of the OpenPGP standard
	"unrar"                      # The RAR uncompression program
	"gdb"                        # The GNU Debugger
	"wakatime"                   # Command line interface used by all WakaTime text editor plugins
	"ueberzug"                   # Command line util which allows to display images in combination with X11
	"bash-completion"            # Programmable completion for the bash shell
	"bash-language-server"       # Bash language server implementation based on Tree Sitter and its grammar for Bash
	"typescript-language-server" # Language Server Protocol (LSP) implementation for TypeScript using tsserver
	"prettierd"                  # prettier, as a daemon, for ludicrous formatting speed
	"clang"                      # C language family frontend for LLVM
	"typos"                      # Source code spell checker
	"rustcat"                    # A modern port listener and reverse shell
)

NORMAL_PROFILE=(
	"ripgrep"          # Better grep
	"python"           # Programming language
	"python-pip"       # Python package manager
	"python-gobject"   # Ui creation (polybar mpris support)
	"flatpak"          # Flatpak package manager
	"bat"              # Better cat
	"exa"              # Better ls
	"croc"             # File transfer utility
	"mpv"              # Image/Video player
	"ffmpeg"           # Audio/Image/Video file converter
	"yt-dlp"           # Better YouTube downloader
	"neovim"           # Vim-like text editor
	"fish"             # New shell
	"fisher"           # Fish plugin manager
	"oh-my-posh-bin"   # Shell prompt
	"fzf"              # Fuzzy finder
	"libqalculate"     # Calculator (qalc)
	"cava"             # Audio visualizer
	"ttf-font-awesome" # Font Awesome font
	"playerctl"        # Command-line utility and library for controlling media players
	"mpv-mpris"        # mpv mpris support
	"update-grub"      # Utility for updating grup config
	"btop"             # System monitor tool
	"reflector"        # Pacman mirror sorter
	"pigz"             # Parallel implementation of the gzip file compressor
	"garuda-hooks"     # Garuda pacman hooks
	"mpdris2"          # MPRIS2 support for MPD
	"mpd"              # Flexible, powerful, server-side application for playing music
	"mpc"              # Minimalist command line interface to MPD
	"ncmpcpp"          # Almost exact clone of ncmpc with some new features
	"brightnessctl"    # Lightweight brightness control tool
	"clipster"         # Python clipboard manager
	"sptlrx-bin"       # Timesynced Spotify lyrics in your terminal
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
	"pipewire"            # Low-latency audio/video router and processor
	"pipewire-alsa"       # Low-latency audio/video router and processor - ALSA configuration
	"pipewire-jack"       # Low-latency audio/video router and processor - JACK support
	"pipewire-pulse"      # Low-latency audio/video router and processor - PulseAudio replacement
	"pipewire-v4l2"       # Low-latency audio/video router and processor - V4L2 interceptor
	"pipewire-zeroconf"   # Low-latency audio/video router and processor - Zeroconf support
	"gst-plugin-pipewire" # Multimedia graph framework - pipewire plugin
	"libpulse"            # A featureful, general-purpose sound server (client library)
	"wireplumber"         # Session / policy manager implementation for PipeWire
	"sof-firmware"        # Sound Open Firmware
	"realtime-privileges" # Realtime privileges for users
	"pamixer"             # Pulseaudio command-line mixer like amixer
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
	"sddm"                             # QML based X11 and Wayland display manager
	"ark"                              # Archive Manager
	"dolphin"                          # File Manager
	"partitionmanager"                 # Partition Manager
	"gwenview"                         # Image viewer
	"polkit-kde-agent"                 # Daemon providing a polkit authentication UI
	"qt5-imageformats"                 # Add more image formats (webp)
	"ulauncher"                        # Application launcher for Linux
	"caprine"                          # Messenger app for Linux
	"discord"                          # VoIP and instant messaging social platform
	"firefox-developer-edition"        # Web browser for developers
	"ff2mpv-native-messaging-host-git" # Open video in mpv
	"spotify"                          # Music client
	"spicetify-cli"                    # Cli for extending spotify
	"kitty-git"                        # GPU accelerated terminal
	"polybar-git"                      # Bar
	"dbus-python"                      # Python bindings for DBUS (Polybar ...)
	"python-google-api-python-client"  # Google API Client Library for Python (Polybar Gmail)
	"python-google-auth-httplib2"      # Google Authentication Library: httplib2 transport (Polybar Gmail)
	"python-google-auth-oauthlib"      # oauthlib integration for Google auth (Polybar Gmail)
	"desktop-file-utils"               # Command line utilities for working with desktop entries
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
	"PatrickF1/colored_man_pages.fish" # Coloured man pages
	"jorgebucaran/nvm.fish"            # Node version manager
	"jethrokuan/z"                     # Z implementation in fish
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
	"Hypr"
)

CUSTOMIZATION_PACKAGES=(
	"lightly-qt"              # A modern style for qt applications
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
)

# Default vars
HELPER="paru"
HELPER_CLONE_PATH="$HOME/.cache/paru/clone"
DOTFILES="$HOME/.dotfiles"
REPO="https://github.com/kamack38/dotfiles"
NEOVIM_CONFIG_DIR="$HOME/.config/nvim"
SPOTIFY_PREFS="$HOME/.config/spotify/prefs"
NVCHAD_URL="https://github.com/NvChad/NvChad"
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
mkdir -p "$HOME/.local/share/fonts"
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
	$HELPER -S --noconfirm --needed --quiet "${RUST_DEV_PROFILE[@]}"
	rustup install stable
	rustup component add clippy
	cargo install cargo-edit
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

# Install fish plugins
echo "${GREEN}:: ${BWHITE}Installing ${BLUE}fish${BWHITE} packages${NC}"
echo "fisher install ${FISH_PACKAGES[*]}" | fish

# Install node & npm packages
echo "${GREEN}:: ${BWHITE}Installing ${BLUE}node${BWHITE} (${NODE_VERSION}) & ${BLUE}npm${BWHITE} packages${NC}"
echo "nvm install ${NODE_VERSION} && npm i --location=global" "${NPM_PACKAGES[@]}" | fish

# Quokka.js
echo "${GREEN}:: ${BWHITE}Installing ${BLUE}quokka.js plugins${NC}"
fish -c "npm i --prefix $HOME/.quokka dotenv-quokka-plugin \
	jsdom-quokka-plugin"

# Install NvChad
if [[ -d "$NEOVIM_CONFIG_DIR/.git" && $(git -C "$NEOVIM_CONFIG_DIR" ls-remote --get-url) == "$NVCHAD_URL"* ]]; then
	echo "${YELLOW}:: ${BLUE}NvChad${BWHITE} is already installed${NC} -- updating"
	git -C "$NEOVIM_CONFIG_DIR" fetch --all
	git -C "$NEOVIM_CONFIG_DIR" pull
else
	echo "${BLUE}:: ${BWHITE}Installing ${BLUE}NvChad${NC}"
	mv "$NEOVIM_CONFIG_DIR" "$HOME/.config/NVIM.BAK"
	git clone "$NVCHAD_URL" "$NEOVIM_CONFIG_DIR" --depth 1

	nvim \
		+"autocmd User PackerComplete sleep 1000m | write $HOME/.packer.sync.result | qall" \
		+PackerSync
	grep -v 'Press' "$HOME/.packer.sync.result"
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
systemctl --user enable mpDris2.service
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

	# Enable services
	if [[ $(systemctl is-enabled sddm-plymouth.service 2>/dev/null) == enabled ]]; then
		echo "${YELLOW}:: ${BWHITE}It seems that you have sddm-plymouth service enabled${NC} -- skipping sddm service"
	else
		sudo systemctl enable sddm.service
	fi

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
		SESSIONS=(
			"awesome"
			"plasma"
		)
		echo "${BLUE}:: ${BWHITE}Select session to which you want to be logged in automatically...${NC}"
		SESSION=$(printf "%s\n" "${SESSIONS[@]}" | fzf --height=20% --layout=reverse || true)
		if [[ $SESSION != "" ]]; then
			echo "${BLUE}:: ${BWHITE}Enabling automatic login...${NC}"
			sudo tee /etc/sddm.conf.d/autologin.conf >/dev/null <<EOT
[Autologin]
User=${CURRENT_USER}
Session=plasma
EOT
		else
			echo "${RED}:: ${BHWITE}No session selected${NC} -- skipping"
		fi
	fi
fi

if [[ $(pacman -Q grub) ]]; then
	# Detect login manager
	ALL_SERVICES=$(systemctl list-unit-files)
	if [[ $(echo "$ALL_SERVICES" | grep 'sddm.service' | awk '{ print $2 }') == enabled ]]; then
		LOGIN_MANAGER="sddm"
	elif [[ $(echo "$ALL_SERVICES" | grep 'lightdm.service' | awk '{ print $2 }') == enabled ]]; then
		LOGIN_MANAGER="lightdm"
	elif [[ $(echo "$ALL_SERVICES" | grep 'lxdm.service' | awk '{ print $2 }') == enabled ]]; then
		LOGIN_MANAGER="lxdm"
	else
		LOGIN_MANAGER="none"
	fi

	if [ "$LOGIN_MANAGER" == "none" ]; then
		echo "${YELLOW}:: ${BWHITE}You're not using any login manager or plymouth is already installed${NC} -- skipping plymouth install"
	else
		echo "${BLUE}:: ${BWHITE}You're using ${BLUE}${LOGIN_MANAGER}${NC}"
		echo "${BLUE}:: ${BWHITE}Installing plymouth...${NC}"

		# Add archcraft repository
		archcraft
		sudo pacman -Sy
		$HELPER -S --noconfirm --needed --quiet "${PLYMOUTH_PACKAGES[@]}"

		# Set default plymouth theme
		sudo plymouth-set-default-theme -R archcraft

		# Correct hooks
		if grep -q "^HOOKS=.*systemd.*" /etc/mkinitcpio.conf; then
			echo "${BLUE}:: ${BWHITE}You're using ${BLUE} systemd hook${NC} -- correcting hooks"
			PLYMOUTH_HOOK_PARENT="systemd"
			PLYMOUTH_HOOK="sd-plymouth"
			ENCRYPT_PLYMOUTH_HOOK="sd-encrypt"
		else
			PLYMOUTH_HOOK_PARENT="udev"
			PLYMOUTH_HOOK="plymouth"
			ENCRYPT_PLYMOUTH_HOOK="plymouth-encrypt"
		fi

		CHANGED="false"

		# Plymouth hook
		if ! grep -q "^HOOKS=.*${PLYMOUTH_HOOK}.*" /etc/mkinitcpio.conf; then
			echo "${YELLOW}:: ${BWHITE}Adding ${PLYMOUTH_HOOK} hook...${NC}"
			sudo sed -i "s,\(^HOOKS=.*\)${PLYMOUTH_HOOK_PARENT}\(.*\),\1${PLYMOUTH_HOOK_PARENT} ${PLYMOUTH_HOOK}\2," "/etc/mkinitcpio.conf"
			CHANGED="true"

		else
			echo "${YELLOW}:: ${BWHITE}${PLYMOUTH_HOOK} hook already exists${NC} -- skipping"
		fi

		# Encrypt hook
		if ! grep -q "^HOOKS=.*${ENCRYPT_PLYMOUTH_HOOK}.*" /etc/mkinitcpio.conf; then
			echo "${YELLOW}:: ${BWHITE}Adding ${ENCRYPT_PLYMOUTH_HOOK} hook...${NC}"
			sudo sed -i "s,\(^HOOKS=.*\)encrypt\(.*\),\1${ENCRYPT_PLYMOUTH_HOOK}\2," "/etc/mkinitcpio.conf"
			CHANGED="true"
		else
			echo "${YELLOW}:: ${BWHITE}${ENCRYPT_PLYMOUTH_HOOK} hook already exists${NC} -- skipping"
		fi

		# Zfs hook
		if ! grep -q "^HOOKS=.*plymouth-zfs.*" /etc/mkinitcpio.conf; then
			if grep -q "^HOOKS=.*zfs.*" /etc/mkinitcpio.conf; then
				echo "${YELLOW}:: ${BWHITE}Adding plymouth-zfs hook...${NC}"
				$HELPER -S --noconfirm --needed --quiet plymouth-zfs
				sudo sed -i "s,\(^HOOKS=.*\)zfs\(.*\),\1plymouth-zfs\2," "/etc/mkinitcpio.conf"
				CHANGED="true"
			else
				echo "${YELLOW}:: ${BWHITE}Zfs hook not detected${NC} -- skipping"
			fi
		else
			echo "${YELLOW}:: ${BWHITE}plymouth-zfs hook already exists${NC} -- skipping"
		fi

		# Create initial ramdisk
		if [ "${CHANGED}" == "true" ]; then
			sudo mkinitcpio -P
		fi

		# Update grub config
		sudo sed -i "s,\(GRUB_CMDLINE_LINUX_DEFAULT=\".*\)\(\"\),\1 quiet splash vt.global_cursor_default=0\2," "/etc/default/grub"
		sudo grub-mkconfig -o /boot/grub/grub.cfg

		# Change login manager
		sudo systemctl disable "${LOGIN_MANAGER}.service"
		sudo systemctl enable "${LOGIN_MANAGER}-plymouth.service"
	fi
fi

if [[ $(pacman -Q xorg-server) ]]; then
	echo "${YELLOW}:: ${BWHITE}Xorg server detected${NC}"

	source "$HOME/scripts/repos.sh"
	archcraft

	echo "${BLUE}:: ${BWHITE}Installing customization packages...${NC}"
	$HELPER -S --noconfirm --needed --quiet "${CUSTOMIZATION_PACKAGES[@]}"

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
		$HELPER -S --noconfirm --needed --quiet "archcraft-sddm-theme-default"

		echo "${BLUE}:: ${BWHITE}Configuring sddm...${NC}"
		sudo tee /etc/sddm.conf.d/30-theme.conf >/dev/null <<EOF
[Theme]
Current=archcraft
CursorTheme=Fluent-cursors
EOF
	fi
fi

# Enable password feedback
sudo mkdir -p /etc/sudoers.d
sudo tee /etc/sudoers.d/pwfeedback >/dev/null <<EOT
Defaults pwfeedback
EOT
sudo chmod 750 /etc/sudoers.d/pwfeedback

read -rp "${BLUE}:: ${BWHITE}Do you want to setup additional programming fonts? [Y/n]${NC}: " fonts_setup

if [[ $fonts_setup != n* ]]; then
	echo "${BLUE}:: ${BWHITE}Installing fonts...${NC}"
	bash "$HOME/scripts/fonts.sh"
fi

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
			echo "${BLUE}:: ${BWHITE}Disabling root login...${NC}"
			sudo tee -a $SSH_PATH >/dev/null <<EOT
PermitRootLogin no
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
	sudo chmod 700 -R /etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.weekly /etc/cron.monthly
	sudo chmod 600 /etc/cron.deny

	echo "${BLUE}:: ${BWHITE}Setting up ${BLUE}iptables${BWHITE}...${NC}"
	sudo iptables -F # Clear all rules
	sudo iptables -X

	sudo iptables -N TCP
	sudo iptables -N UDP
	sudo iptables -P FORWARD DROP
	sudo iptables -P OUTPUT ACCEPT
	sudo iptables -P INPUT DROP
	sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A INPUT -i lo -j ACCEPT
	sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
	sudo iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
	sudo iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
	sudo iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP
	sudo iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
	sudo iptables -A INPUT -p tcp -j REJECT --reject-with tcp-reset
	sudo iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable
	sudo iptables -t raw -I PREROUTING -m rpfilter --invert -j DROP
	sudo iptables -I TCP -p tcp -m recent --update --seconds 60 --name TCP-PORTSCAN -j REJECT --reject-with tcp-reset
	sudo iptables -D INPUT -p tcp -j REJECT --reject-with tcp-reset
	sudo iptables -A INPUT -p tcp -m recent --set --name TCP-PORTSCAN -j REJECT --reject-with tcp-reset
	sudo iptables -I UDP -p udp -m recent --update --seconds 60 --name UDP-PORTSCAN -j REJECT --reject-with icmp-port-unreachable
	sudo iptables -D INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
	sudo iptables -A INPUT -p udp -m recent --set --name UDP-PORTSCAN -j REJECT --reject-with icmp-port-unreachable

	sudo iptables-save | sudo tee /etc/iptables/iptables.rules >/dev/null
	sudo systemctl enable --now iptables.service

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

if [[ $reboot_prompt != n* ]]; then
	echo "${YELLOW}:: ${BWHITE}Rebooting...${NC}"
	systemctl reboot
fi
