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
CURRENT_USER="$USER"

HYPRLAND_PACKAGES=(
	"hyprland-git"           # A dynamic tiling Wayland compositor based on wlroots that doesn't sacrifice on its looks.
	"hyprpaper-git"          # A blazing fast wayland wallpaper utility with IPC controls.
	"wl-clipboard"           # Command-line copy/paste utilities for Wayland
	"wlogout"                # Logout menu for wayland
	"polkit-kde-agent"       # Daemon providing a polkit authentication UI for KDE
	"xdg-desktop-portal"     # Desktop integration portals for sandboxed apps
	"xdg-desktop-portal-wlr" # xdg-desktop-portal backend for wlroots
	"wev"                    # A tool for debugging wayland events, similar to xev
	"sddm"                   # QML based X11 and Wayland display manager
	"autorandr"              # Auto-detect connected display hardware and load appropiate X11 setup using xrandr
)

echo "${GREEN}:: ${BWHITE}Installing Hyprland and its components...${NC}"
$HELPER -S --noconfirm --needed --quiet "${HYPRLAND_PACKAGES[@]}"

echo "${BLUE}:: ${BWHITE}Adding custom Hyprland session...${NC}"
sudo tee /usr/share/wayland-sessions/hyprland_custom.desktop >/dev/null <<EOT
[Desktop Entry]
Name=Hyprland (Custom)
Comment=An intelligent dynamic tiling Wayland compositor
Exec=/home/$CURRENT_USER/.local/bin/hl_wrapper
Type=Application
EOT
