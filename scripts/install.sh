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
	"jre-openjdk"
	"git-delta"
	"onefetch"
	"neofetch-git"
	"github-cli"
	"visual-studio-code-bin"
	"gnome-keyring"
	"libsecret"
	"tldr"
	"dust"
	"bottom"
	"shfmt-bin"
	"ngrok"
	"jq"
	"gnupg"
	"unrar"
	"gdb"
	"wakatime"
	"ueberzug"
	"bash-completion"
	"bash-language-server"
	"typescript-language-server"
	"prettierd"
	"ccls"
	"typos"
)

VM_PROFILE=("virt-manager-meta")

NORMAL_PROFILE=(
	"ripgrep"
	"python"
	"python-pip"
	"python-gobject"
	"flatpak"
	"bat"
	"exa"
	"croc"
	"mpv"
	"ffmpeg"
	"yt-dlp"
	"neovim"
	"fish"
	"fisher"
	"discord"
	"firefox-developer-edition"
	"ff2mpv-native-messaging-host-git"
	"oh-my-posh-bin"
	"fzf"
	"caprine"
	"spotify"
	"spicetify-cli"
	"libqalculate"
	"cava"
	"ttf-font-awesome"
	"rofi"
	"playerctl"
	"mpv-mpris"
	"update-grub"
	"alacritty"
	"polybar-git"
	"reflector"
	"${DEV_PROFILE[@]}"
)

GAMING_PROFILE=(
	"mangohud"
	"input-devices-support"
	"piper"
	"steam"
	"proton-ge-custom"
	"lutris-git"
	"wine"
)

SOUND_PROFILE=(
	'chaotic-aur/alsa-support'
)

BLUETOOTH_PROFILE=("bluetooth-support")

NETWORK_PROFILE=("")

NVIDIA_DRIVERS=(
	"nvidia-dkms"
	"nvidia-utils"
	"lib32-nvidia-utils"
	"nvidia-settings"
	"vulkan-icd-loader"
	"lib32-vulkan-icd-loader"
)

AMD_DRIVERS=(
	"lib32-mesa"
	"vulkan-radeon"
	"lib32-vulkan-radeon"
	"vulkan-icd-loader"
	"lib32-vulkan-icd-loader"
)

INTEL_DRIVERS=(
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
NVCHAD_URL="https://github.com/NvChad/NvChad"
TIME_ZONE="Europe/Warsaw"
MAIN_LOCALE="en_GB.UTF-8"
SECONDARY_LOCALE="pl_PL.UTF-8"

# Show greetings
echo "   ___  __    _____ ______  _________  ________"
echo "  |\  \|\  \ |\   _ \  __ \|\_____   \|\   __  \ "
echo "  \ \  \/  /|\ \  \\\\\__\ \  \|_____\  \ \  \|\  \    Kamack38"
echo "   \ \   ___  \ \  \\\\|__| \  \|______  \ \   __  \   ${BLUE}https://twitter.com/kamack38${NC}"
echo "    \ \  \\\\ \  \ \  \    \ \  \| ____\  \ \  \|\  \  https://github.com/kamack38"
echo "     \ \__\\\\ \__\ \__\    \ \__\|\_______\ \_______\ "
echo "      \|__| \|__|\|__|     \|__|\|_______|\|_______|"
echo ""
echo -e "		${RED}Thank you for using my script! ${NC}"

echo "${BLUE}:: ${BWHITE}Doing a system update, cause stuff may break if it's not the latest version...${NC}"
sudo pacman --noconfirm -Syu

echo "${BLUE}:: ${BWHITE}Installing basic packages...${NC}"
sudo pacman -S --noconfirm --needed base-devel wget git

# Create dirs
echo "${BLUE}:: ${BWHITE}Creating directories...${NC}"
mkdir -p $HOME/.local/share/fonts
mkdir -p $NEOVIM_CONFIG_DIR
mkdir -p $HOME/.srcs

# Set time zone
ln -sf "/usr/share/zoneinfo/${TIME_ZONE}" /etc/localtime
hwclock --systohc

# Generate locale
echo "${BLUE}:: ${BWHITE}Generating locales${NC}"
sudo wget 'https://raw.githubusercontent.com/archcraft-os/core-packages/main/archcraft-mirrorlist/archcraft-mirrorlist' -O /etc/pacman.d/archcraft-mirrorlist
sudo tee -a /etc/locale.gen >/dev/null <<EOT
#
# Locales enabled by dotfiles install script
en_US.UTF-8 UTF-8
${MAIN_LOCALE} UTF-8
${SECONDARY_LOCALE} UTF-8
EOT
sudo locale-gen

# Set locale
echo "${BLUE}:: ${BWHITE}Setting locales${NC}"
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

# Install helper
if ! command -v $HELPER &>/dev/null; then
	echo "${YELLOW}:: ${BWHITE}It seems that you don't have ${BLUE}$HELPER${BWHITE} installed${NC} -- installing"
	git clone https://aur.archlinux.org/$HELPER.git $HOME/.srcs/$HELPER
	(cd $HOME/.srcs/$HELPER/ && makepkg --noconfirm -si)
else
	echo "${GREEN}:: ${BLUE}${HELPER}${BWHITE} is already installedR installed${NC} -- skipping"
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

# Add additional repositories
source "$HOME/scripts/repos.sh"
multilib
chaotic_aur
sudo $HELPER -Sy

# Install drivers
VGA_INFO=$(lspci -vnn | grep VGA)
if [[ $VGA_INFO == *"NVIDIA"* ]]; then
	echo "${GREEN}:: ${BWHITE}Installing ${BLUE}NVIDIA${BWHITE} drivers${NC}"
	$HELPER -S --noconfirm --needed --quiet "${NVIDIA_DRIVERS[@]}"
else
	echo "${YELLOW}:: ${BLUE}NVIDIA${BWHITE} hardware not detected${NC} -- skipping"
fi

if [[ $VGA_INFO == *"AMD"* ]]; then
	echo "${GREEN}:: ${BWHITE}Installing ${BLUE}AMD${BWHITE} drivers${NC}"
	$HELPER -S --noconfirm --needed --quiet "${AMD_DRIVERS[@]}"
else
	echo "${YELLOW}:: ${BLUE}AMD${BWHITE} hardware not detected${NC} -- skipping"

fi

if [[ $VGA_INFO == *"INTEL"* ]]; then
	echo "${GREEN}:: ${BWHITE}Installing ${BLUE}INTEL${BWHITE} drivers${NC}"
	$HELPER -S --noconfirm --needed --quiet "${INTEL_DRIVERS[@]}"
else
	echo "${YELLOW}:: ${BLUE}INTEL${BWHITE} hardware not detected${NC} -- skipping"
fi

# Install packages
echo "${GREEN}:: ${BWHITE}Installing ${BLUE}default${BWHITE} packages using ${BLUE}${HELPER}${NC}"
$HELPER -S --noconfirm --needed --quiet --mflags='-j$(nproc)' "${NORMAL_PROFILE[@]}"

# Additional packages
echo "${BLUE}:: ${BWHITE}Which packages do you want to install?${NC}"
echo "	1) Gaming 2) Virtual Machine 3) Sound 4) Bluetooth 5) Network"
read -rp "${BLUE}:: ${BWHITE}Packages to install (eg: 1 2 3): " additional_packages

if [[ $additional_packages == *"1"* ]]; then
	echo "${BLUE}:: ${BWHITE}Installing ${BLUE}gaming${BWHITE} packages?${NC}"
	$HELPER -S --noconfirm --needed --quiet "${GAMING_PROFILE[@]}"
fi
if [[ $additional_packages == *"2"* ]]; then
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}virtual machine${BWHITE} support?${NC}"
	$HELPER -S --noconfirm --needed --quiet "${VM_PROFILE[@]}"
fi
if [[ $additional_packages == *"3"* ]]; then
	echo "${RED}:: ${BWHITE}This feature has not been implemented yet${NC}"
	# echo "${BLUE}:: ${BWHITE}Adding ${BLUE}sound${BWHITE} support?${NC}"
	# $HELPER -S --noconfirm --needed --quiet "${SOUND_PROFILE[@]}"
fi
if [[ $additional_packages == *"4"* ]]; then
	echo "${BLUE}:: ${BWHITE}Adding ${BLUE}bluetooth${BWHITE} support?${NC}"
	$HELPER -S --noconfirm --needed --quiet "${BLUETOOTH_PROFILE[@]}"
fi
if [[ $additional_packages == *"5"* ]]; then
	echo "${RED}:: ${BWHITE}This feature has not been implemented yet${NC}"
	# echo "${BLUE}:: ${BWHITE}Adding ${BLUE}network${BWHITE} support?${NC}"
	# $HELPER -S --noconfirm --needed --quiet "${NETWORK_PROFILE[@]}"
fi

# Install pip packages
echo -e "${GREEN}:: ${BWHITE}Installing ${BLUE}pip${BWHITE} packages${NC}"
pip install --upgrade dbus-python \
	google-api-python-client \
	google-auth-httplib2 \
	google-auth-oauthlib \
	neovim

# Add .local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Install node & npm packages
echo -e "${GREEN}:: ${BWHITE}Installing ${BLUE}node${BWHITE} & ${BLUE}npm${BWHITE} packages${NC}"
fish -c 'fisher install jorgebucaran/nvm.fish && nvm install lts && nvm use lts && set --universal nvm_default_version lts'
fish -c 'nvm use lts && npm i -g carbon-now-cli \
	yarn \
	pm2 \
	neovim \
	npm-check-updates \
	git-cz'

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
		+'autocmd User PackerComplete sleep 100m | write $HOME/.packer.sync.result | qall' \
		+PackerSync
	cat $HOME/.packer.sync.result | grep -v 'Press'
fi

# Enable spicetify
if [[ ! -f "$HOME/.config/spicetify/Backup/xpui.spa" ]]; then
	echo "${BLUE}:: ${BWHITE}Enabling ${BLUE}spicetify${BWHITE}...${NC}"
	spicetify backup apply
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
	echo "${GREEN}:: ${BWHITE}Installing KDE..."
	bash "$HOME/scripts/kde.sh"
	;;

3)
	echo "${GREEN}:: ${BWHITE}Installing xfce..."
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

read -rp "${BLUE}:: ${BWHITE}Do you want to add additional pacman repositories (blackarch, archcraft)? [y/N]${NC}: " repos_script

if [[ $repos_script == y* ]]; then
	archcraft
	chaotic_aur
	blackarch
fi

read -rp "${BLUE}:: ${BWHITE}Do you want to run script for asus laptops? [y/N]${NC}: " asus_script

if [[ $asus_script == y* ]]; then
	echo "${BLUE}:: ${BWHITE}Running asus script...${NC}"
	bash $HOME/scripts/asus.sh
fi

read -rp "${BLUE}:: ${BWHITE}Do you want to run script for razer hardware? [y/N]${NC}: " razer_script

if [[ $razer_script == y* ]]; then
	echo "${BLUE}:: ${BWHITE}Running razer script...${NC}"
	bash $HOME/scripts/razer.sh
fi

read -rp "${RED}:: ${BWHITE}Do you want to reboot? [y/N]${NC}: " reboot_prompt

if [[ $reboot_prompt == y* ]]; then
	echo "${YELLOW}:: ${BWHITE}Rebooting...${NC}"
	systemctl reboot
fi
