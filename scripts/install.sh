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
	"ccls"                       # C/C++/ObjC language server supporting cross references, hierarchies, completion and semantic highlighting
	"typos"                      # Source code spell checker
	"rustcat"                    # A modern port listener and reverse shell
)

VM_PROFILE=("virt-manager-meta")

NORMAL_PROFILE=(
	"ripgrep"                          # Better grep
	"python"                           # Programming language
	"python-pip"                       # Python package manager
	"python-gobject"                   # Ui creation (polybar mpris support)
	"flatpak"                          # Flatpak package manager
	"bat"                              # Better cat
	"exa"                              # Better ls
	"croc"                             # File transfer utility
	"mpv"                              # Image/Video player
	"ffmpeg"                           # Audio/Image/Video file converter
	"yt-dlp"                           # Better YouTube downloader
	"neovim"                           # Vim-like text editor
	"fish"                             # New shell
	"fisher"                           # Fish plugin manager
	"discord"                          # VoIP and instant messaging social platform
	"firefox-developer-edition"        # Web browser for developers
	"ff2mpv-native-messaging-host-git" # Open video in mpv
	"oh-my-posh-bin"                   # Shell prompt
	"fzf"                              # Fuzzy finder
	"caprine"                          # Messenger app for Linux
	"spotify"                          # Music client
	"spicetify-cli"                    # Cli for extending spotify
	"libqalculate"                     # Calculator (qalc)
	"cava"                             # Audio visualizer
	"ttf-font-awesome"                 # Font Awesome font
	"rofi"                             # Better dmenu, menu
	"playerctl"                        # Command-line utility and library for controlling media players
	"mpv-mpris"                        # mpv mpris support
	"update-grub"                      # Utility for updating grup config
	"btop"                             # System monitor tool
	"kitty-git"                        # GPU accelerated terminal
	"polybar-git"                      # Bar
	"reflector"                        # Pacman mirror sorter
	"pigz"                             # Parallel implementation of the gzip file compressor
	"chaotic-aur/garuda-hooks"         # Garuda pacman hooks
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
)

BLUETOOTH_PROFILE=("bluetooth-support")

RUST_DEV=(
	"rustup"
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

AMD_DRIVERS=(
	"garuda-video-linux-config"
	"lib32-mesa"
	"vulkan-radeon"
	"lib32-vulkan-radeon"
	"vulkan-icd-loader"
	"lib32-vulkan-icd-loader"
)

INTEL_DRIVERS=(
	"garuda-video-linux-config"
	"lib32-mesa"
	"vulkan-intel"
	"lib32-vulkan-intel"
	"vulkan-icd-loader"
	"lib32-vulkan-icd-loader"
)

# Default vars
HELPER="paru"
DOTFILES="$HOME/.dotfiles"
REPO="https://github.com/kamack38/linux-dotfiles"
NEOVIM_CONFIG_DIR="$HOME/.config/nvim"
SPOTIFY_PREFS="$HOME/.config/spotify/prefs"
NVCHAD_URL="https://github.com/NvChad/NvChad"
NODE_VERSION="lts"
TIME_ZONE="Europe/Warsaw"
MAIN_LOCALE="en_GB.UTF-8"
SECONDARY_LOCALE="pl_PL.UTF-8"
SPELLCHECK_LOCALES=("${MAIN_LOCALE/_*/}" "${SECONDARY_LOCALE/_*/}")
KB_LAYOUT="pl"
MAKEFLAGS="-j$(nproc)"

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
sudo pacman -S --noconfirm --needed base-devel wget git

# Create dirs
echo "${BLUE}:: ${BWHITE}Creating directories...${NC}"
mkdir -p $HOME/.local/share/fonts
mkdir -p $NEOVIM_CONFIG_DIR
mkdir -p $HOME/.srcs

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

# Install helper
if ! command -v $HELPER &>/dev/null; then
	echo "${YELLOW}:: ${BWHITE}It seems that you don't have ${BLUE}$HELPER${BWHITE} installed${NC} -- installing"
	git clone https://aur.archlinux.org/$HELPER.git /tmp/$HELPER
	(cd /tmp/$HELPER/ && makepkg --noconfirm -si)
else
	echo "${GREEN}:: ${BLUE}${HELPER}${BWHITE} is already installed${NC} -- skipping"
fi

# Install dotfiles
if [[ -d "$DOTFILES" && "$(git -C $DOTFILES ls-remote --get-url)" == "$REPO"* ]]; then
	echo "${YELLOW}:: ${BLUE}dotfiles${BWHITE} are already installed${NC} -- updating"
	git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
	git --git-dir="$DOTFILES" --work-tree="$HOME" pull --all
else
	echo "${YELLOW}:: ${BWHITE}Cloning ${BLUE}dotfiles${NC} from ${BLUE}${REPO#*//*/}${NC}"
	git clone --bare $REPO $DOTFILES
	git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
	git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
	git --git-dir="$DOTFILES" --work-tree="$HOME" checkout --force
fi

# Load XDG variables
echo "${GREEN}:: ${BWHITE}Loading ${BLUE}XDG${BWHITE} paths...${NC}"
eval "$(sed -n '/^# XDG/,${p;/^# Keybindings/q}' .config/fish/config.fish)"

# Add additional repositories
source "$HOME/scripts/repos.sh"
multilib
chaotic_aur
garuda
sudo $HELPER -Sy

# Install CPU drivers
proc_type=$(lscpu)
if grep -E "GenuineIntel" <<<${proc_type}; then
	echo "${BLUE}:: ${BWHITE}Installing ${BLUE}Intel${BWHITE} microcode...${NC}"
	echo "Installing Intel microcode"
	sudo pacman -S --noconfirm --needed intel-ucode
	proc_ucode=intel-ucode.img
elif grep -E "AuthenticAMD" <<<${proc_type}; then
	echo "${BLUE}:: ${BWHITE}Installing ${BLUE}AMD${BWHITE} microcode...${NC}"
	sudo pacman -S --noconfirm --needed amd-ucode
	proc_ucode=amd-ucode.img
fi

# Install GPU drivers
VGA_INFO=$(lspci -vnn | grep VGA)
if [[ $VGA_INFO == *"NVIDIA"* ]]; then
	echo "${GREEN}:: ${BWHITE}Installing ${BLUE}NVIDIA${BWHITE} drivers${NC}"
	$HELPER -S --noconfirm --needed --quiet "${NVIDIA_DRIVERS[@]}"
else
	echo "${YELLOW}:: ${BLUE}NVIDIA${BWHITE} GPU not detected${NC} -- skipping"
fi

if [[ $VGA_INFO == *"AMD"* ]]; then
	echo "${GREEN}:: ${BWHITE}Installing ${BLUE}AMD${BWHITE} drivers${NC}"
	$HELPER -S --noconfirm --needed --quiet "${AMD_DRIVERS[@]}"
else
	echo "${YELLOW}:: ${BLUE}AMD${BWHITE} GPU not detected${NC} -- skipping"

fi

if [[ $VGA_INFO == *"INTEL"* ]]; then
	echo "${GREEN}:: ${BWHITE}Installing ${BLUE}INTEL${BWHITE} drivers${NC}"
	$HELPER -S --noconfirm --needed --quiet "${INTEL_DRIVERS[@]}"
else
	echo "${YELLOW}:: ${BLUE}INTEL${BWHITE} GPU not detected${NC} -- skipping"
fi

# Install packages
echo "${GREEN}:: ${BWHITE}Installing ${BLUE}default${BWHITE} packages using ${BLUE}${HELPER}${NC}"
$HELPER -S --noconfirm --needed --quiet "${NORMAL_PROFILE[@]}"

# Additional packages
echo "${BLUE}:: ${BWHITE}Which packages do you want to install?${NC}"
echo "	1) Gaming 2) Virtual Machine 3) Sound 4) Bluetooth 5) Rust-DEV"
read -rp "${BLUE}:: ${BWHITE}Packages to install (eg: 1 2 3): " additional_packages

if [[ $additional_packages == *"1"* ]]; then
	echo "${BLUE}:: ${BWHITE}Installing ${BLUE}gaming${BWHITE} packages...${NC}"
	$HELPER -S --noconfirm --needed --quiet "${GAMING_PROFILE[@]}"
fi
if [[ $additional_packages == *"2"* ]]; then
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}virtual machine${BWHITE} support...${NC}"
	$HELPER -S --noconfirm --needed --quiet "${VM_PROFILE[@]}"

	# Enable services
	sudo systemctl enable --now libvirtd.service

	# Autostart bridge
	sudo virsh net-autostart default
	sudo virsh net-start default
fi
if [[ $additional_packages == *"3"* ]]; then
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}sound${BWHITE} support...${NC}"
	yes | $HELPER -S --needed --quiet "${SOUND_PROFILE[@]}"
	systemctl enable --user pipewire-pulse.service

	# Create realtime group
	getent group "realtime" &>/dev/null || groupadd -r realtime

	# Add all users to group realtime
	echo "${BLUE}:: ${BWHITE}Adding users to realtime group...${NC}"
	for ID in $(cat /etc/passwd | grep /home | cut -d ':' -f1); do
		(sudo usermod -aG realtime $ID)
	done
fi
if [[ $additional_packages == *"4"* ]]; then
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}bluetooth${BWHITE} support...${NC}"
	$HELPER -S --noconfirm --needed --quiet "${BLUETOOTH_PROFILE[@]}"
fi
if [[ $additional_packages == *"5"* ]]; then
	echo "${BLUE}:: ${BWHITE}Installing rust profile...${NC}"
	$HELPER -S --noconfirm --needed --quiet "${RUST_DEV[@]}"
	rustup install stable
	rustup component add clippy
	cargo install cargo-edit
fi

# Install spellchecking
echo "${GREEN}:: ${BWHITE}Installing ${BLUE}spellchecking${BWHITE} and ${BLUE}thesaurus${BWHITE} for ${BLUE}${SPELLCHECK_LOCALES[@]}${BWHITE}...${NC}"
for LOCALE in "${SPELLCHECK_LOCALES[@]}"; do
	$HELPER -S --noconfirm --needed --quiet "aspell-${LOCALE}" "mythes-${LOCALE}"
done

# Install pip packages
echo -e "${GREEN}:: ${BWHITE}Installing ${BLUE}pip${BWHITE} packages${NC}"
pip install --no-warn-script-location --upgrade dbus-python \
	google-api-python-client \
	google-auth-httplib2 \
	google-auth-oauthlib \
	neovim

# Add .local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Install node & npm packages
echo -e "${GREEN}:: ${BWHITE}Installing ${BLUE}node${BWHITE} & ${BLUE}npm${BWHITE} packages${NC}"
fish -c "fisher install jorgebucaran/nvm.fish && nvm install ${NODE_VERSION} && npm i -g npm \
	yarn \
	pm2 \
	neovim \
	npm-check-updates \
	git-cz"

echo "${GREEN}:: ${BWHITE}Installing ${BLUE}quokka.js plugins${NC}"
fish -c 'npm i --prefix $HOME/.quokka dotenv-quokka-plugin \
	jsdom-quokka-plugin'

# Install NvChad
if [[ -d "$NEOVIM_CONFIG_DIR/.git" && $(git -C $NEOVIM_CONFIG_DIR ls-remote --get-url) == "$NVCHAD_URL"* ]]; then
	echo "${YELLOW}:: ${BLUE}NvChad${BWHITE} is already installed${NC} -- updating"
	git -C $NEOVIM_CONFIG_DIR fetch --all
	git -C $NEOVIM_CONFIG_DIR pull
else
	echo "${BLUE}:: ${BWHITE}Installing ${BLUE}NvChad${NC}"
	mv $NEOVIM_CONFIG_DIR $HOME/.config/NVIM.BAK
	git clone https://github.com/NvChad/NvChad $NEOVIM_CONFIG_DIR --depth 1

	nvim \
		+'autocmd User PackerComplete sleep 1000m | write $HOME/.packer.sync.result | qall' \
		+PackerSync
	cat $HOME/.packer.sync.result | grep -v 'Press'
fi

# Enable spicetify
if [[ ! -f "$HOME/.config/spicetify/Backup/xpui.spa" ]]; then
	echo "${YELLOW}:: ${BWHITE}Fixing ${BLUE}spicetify${BWHITE}...${NC}"
	sed -i "s,\(prefs_path.*=\).*,\1 $SPOTIFY_PREFS," "$HOME/.config/spicetify/config-xpui.ini"
	echo "${YELLOW}:: ${BWHITE}Run ${BLUE}spicetify backup apply${BWHITE} to apply spicetify...${NC}"
fi

# Set default shell to fish
if [ ! "$(basename -- "$SHELL")" = "fish" ]; then
	echo "${YELLOW}:: ${BWHITE}Setting default shell to ${BLUE}fish${NC}"
	sudo chsh -s /bin/fish $USER
fi

# Update submodules
echo "${BLUE}:: ${BWHITE}Updating ${BLUE}submodules${NC}"
git --git-dir="$DOTFILES" --work-tree="$HOME" submodule update --init --remote

# Additional tools
echo "${BLUE}:: ${BWHITE}Which DE do you want to install?${NC}"
echo "	1) None 2) KDE 3) xfce"
read -rp "Enter a number (default=1): " de_script

case $de_script in

2)
	bash "$HOME/scripts/kde.sh"
	;;

3)
	bash "$HOME/scripts/xfce.sh"
	;;
*)
	echo "${YELLOW}:: ${BWHITE}Skipping..."
	;;
esac

read -rp "${BLUE}:: ${BWHITE}Do you want to setup additional programming fonts? [Y/n]${NC}: " fonts_setup

if [[ $fonts_setup != n* ]]; then
	echo "${BLUE}:: ${BWHITE}Installing fonts...${NC}"
	bash $HOME/scripts/fonts.sh
fi

read -rp "${BLUE}:: ${BWHITE}Do you want to add additional pacman repositories (archstrike, blackarch, archcraft)? [y/N]${NC}: " repos_script

if [[ $repos_script == y* ]]; then
	archcraft
	chaotic_aur
	blackarch
	archstrike
fi

read -rp "${BLUE}:: ${BWHITE}Do you want to run script for asus laptops? [y/N]${NC}: " asus_script

if [[ $asus_script == y* ]]; then
	echo "${BLUE}:: ${BWHITE}Running asus script...${NC}"
	bash $HOME/scripts/asus.sh
fi

read -rp "${BLUE}:: ${BWHITE}Do you want to add support for razer hardware? [y/N]${NC}: " razer_script

RAZER_PACKAGES=(
	"polychromatic-git"
	"openrazer-meta-git"
)

if [[ $razer_script == y* ]]; then
	echo "${BLUE}:: ${BWHITE}Installing razer drivers & RGB software...${NC}"
	$HELPER -S --noconfirm --needed --quiet "${RAZER_PACKAGES[@]}"

	# Add current user to plugdev group
	CURRENT_USER="$USER"
	sudo gpasswd -a $CURRENT_USER plugdev
fi

read -rp "${BLUE}:: ${BWHITE}Do you want to harden your system? [y/N]${NC}: " harden

if [[ $harden == y* ]]; then
	echo "${BLUE}:: ${BWHITE}Installing security packages...${NC}"
	$HELPER -S --noconfirm --needed --quiet lynis rkhunter

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

	echo "${BLUE}:: ${BWHITE}Setting up ${BLUE}iptables${BWHITE}...${NC}"
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

	sudo iptables-save >/etc/iptables/iptables.rules
	sudo systemctl enable --now iptables.service

	read -rp "${BLUE}:: ${BWHITE}Do you want to scan your device now? [y/N]${NC}: " SCAN
	if [[ $SCAN == y* ]]; then
		echo "${BLUE}:: ${BWHITE}Running ${BLUE}lynis${BWHITE}...${NC}"
		sudo lynis update info
		sudo lynis audit system
		echo "${BLUE}:: ${BWHITE}Checking for ${BLUE}root kits${BWHITE}...${NC}"
		sudo rkhunter --check --sk
	fi
fi

read -rp "${RED}:: ${BWHITE}Do you want to reboot? [Y/n]${NC}: " reboot_prompt

if [[ $reboot_prompt == n* ]]; then
	echo "${YELLOW}:: ${BWHITE}Rebooting...${NC}"
	systemctl reboot
fi
