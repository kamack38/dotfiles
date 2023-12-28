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

# Default vars
HELPER="paru"
VGA_INFO=$(lspci -vnn | grep VGA)

echo "${GREEN}:: ${BWHITE}Installing Hyprland...${NC}"
if [[ $VGA_INFO == *"NVIDIA"* ]]; then
	echo "${YELLOW}:: ${BLUE}NVIDIA${BWHITE} card detected!${NC}"
	echo "${GREEN}:: ${BWHITE}Installing ${BLUE}hyprland-nvidia-git${BWHITE}...${NC}"
	$HELPER -S --noconfirm --needed --quiet "hyprland-nvidia-git"
else
	$HELPER -S --noconfirm --needed --quiet "hyprland-git"
fi

HYPRLAND_PACKAGES=(
	"hyprpaper-git"                         # A blazing fast wayland wallpaper utility with IPC controls.
	"wl-clipboard"                          # Command-line copy/paste utilities for Wayland
	"cliphist"                              # clipboard history "manager" for wayland
	"grimblast-git"                         # A helper for screenshots within Hyprland.
	"wlogout"                               # Logout menu for wayland
	"waybar-hyprland-git"                   # Highly customizable Wayland bar for Wlroots based compositors, with workspaces support for Hyprland
	"swaylock-effects"                      # A fancier screen locker for Wayland.
	"swaylockd"                             # A dumb launcher to spawn swaylock and ensure it runs no matter what
	"swayidle"                              # Idle management daemon for Wayland
	"xdg-desktop-portal"                    # Desktop integration portals for sandboxed apps
	"xdg-desktop-portal-hyprland-git"       # xdg-desktop-portal backend for hyprland
	"wev"                                   # A tool for debugging wayland events, similar to xev
	"sddm"                                  # QML based X11 and Wayland display manager
	"autorandr"                             # Auto-detect connected display hardware and load appropiate X11 setup using xrandr
	"dunst"                                 # Customizable and lightweight notification-daemon
	"qt5-wayland"                           # Provides APIs for Wayland
	"libva"                                 # Video Acceleration (VA) API for Linux
	"qt5ct"                                 # Qt5 Configuration Utility
	"spotifywm-git"                         # Makes Spotify more friendly to window managers by settings a class name before opening the window
	"xwaylandvideobridge-cursor-mode-2-git" # A tool to make it easy to stream wayland windows and screens to Xwayland applicatons that don't have native pipewire support
	"wl-mpris-idle-inhibit"                 # Wayland Idle Inhibitor using MPRIS2 as a signal
)

echo "${GREEN}:: ${BWHITE}Installing Hyprland components...${NC}"
$HELPER -S --noconfirm --needed --quiet "${HYPRLAND_PACKAGES[@]}"
