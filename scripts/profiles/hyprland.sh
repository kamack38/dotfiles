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

HYPRLAND_PACKAGES=(
	"hyprland"                        # A highly customizable dynamic tiling Wayland compositor
	"hyprpaper"                       # A blazing fast wayland wallpaper utility with IPC controls.
	"hyprlock"                        # hyprland’s GPU-accelerated screen locking utility
	"rofi-lbonn-wayland-git"          # A window switcher, application launcher and dmenu replacement (fork with Wayland support)
	"wl-clipboard"                    # Command-line copy/paste utilities for Wayland
	"wlsunset"                        # Day/night gamma adjustments for Wayland compositors
	"cliphist"                        # clipboard history "manager" for wayland
	"grimblast-git"                   # A helper for screenshots within Hyprland.
	"wlogout"                         # Logout menu for wayland
	"waybar"                          # Highly customizable Wayland bar for Wlroots based compositors
	"swaylock-effects"                # A fancier screen locker for Wayland.
	"hypridle"                        # hyprland’s idle daemon
	"xdg-desktop-portal"              # Desktop integration portals for sandboxed apps
	"xdg-desktop-portal-hyprland-git" # xdg-desktop-portal backend for hyprland
	"wev"                             # A tool for debugging wayland events, similar to xev
	"sddm"                            # QML based X11 and Wayland display manager
	"autorandr"                       # Auto-detect connected display hardware and load appropriate X11 setup using xrandr
	"dunst"                           # Customizable and lightweight notification-daemon
	"qt6-wayland"                     # Provides APIs for Wayland
	"libva"                           # Video Acceleration (VA) API for Linux
	"qt6ct-kde"                       # Qt 6 Configuration Utility, patched to work correctly with KDE applications
	"spotifywm-git"                   # Makes Spotify more friendly to window managers by settings a class name before opening the window
	"xwaylandvideobridge"             # Utility to allow streaming Wayland windows to X applications
	"wayland-pipewire-idle-inhibit"   # Inhibit wayland idle when computer is playing sound
)

echo "${GREEN}:: ${BWHITE}Installing Hyprland and its components...${NC}"
$HELPER -S --noconfirm --needed --quiet "${HYPRLAND_PACKAGES[@]}"

echo "${GREEN}:: ${BWHITE}Enabling Hyprland services...${NC}"
systemctl enable --now --user wayland-pipewire-idle-inhibit.service
