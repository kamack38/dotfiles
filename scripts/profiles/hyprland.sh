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
	"hyprland"                      # A highly customizable dynamic tiling Wayland compositor
	"hyprpaper"                     # A blazing fast wayland wallpaper utility with IPC controls.
	"hyprlock"                      # hyprland’s GPU-accelerated screen locking utility
	"hypridle"                      # hyprland’s idle daemon
	"rofi-wayland"                  # A window switcher, application launcher and dmenu replacement (fork with Wayland support)
	"rofi-emoji"                    # A Rofi plugin for selecting emojis
	"wl-clipboard"                  # Command-line copy/paste utilities for Wayland
	"hyprsunset"                    # An application to enable a blue-light filter on Hyprland
	"cliphist"                      # clipboard history "manager" for wayland
	"grimblast-git"                 # A helper for screenshots within Hyprland.
	"wlogout"                       # Logout menu for wayland
	"waybar"                        # Highly customizable Wayland bar for Wlroots based compositors
	"acpi"                          # Client for battery, power, and thermal readings
	"xdg-desktop-portal"            # Desktop integration portals for sandboxed apps
	"xdg-desktop-portal-hyprland"   # xdg-desktop-portal backend for hyprland
	"wev"                           # A tool for debugging wayland events, similar to xev
	"sddm"                          # QML based X11 and Wayland display manager
	"autorandr"                     # Auto-detect connected display hardware and load appropriate X11 setup using xrandr
	"dunst"                         # Customizable and lightweight notification-daemon
	"ttf-iosevka-nerd"              # Patched font Iosevka from nerd fonts library (used by Dunst)
	"qt6-wayland"                   # Provides APIs for Wayland
	"libva"                         # Video Acceleration (VA) API for Linux
	"qt6ct-kde"                     # Qt 6 Configuration Utility, patched to work correctly with KDE applications
	"nwg-look"                      # GTK3 settings editor adapted to work on wlroots-based compositors
	"wayland-pipewire-idle-inhibit" # Inhibit wayland idle when computer is playing sound
	"uwsm"                          # A standalone Wayland session manager
	"libnewt"                       # UWSM dependency
	"runapp"                        # Application runner for Linux desktop environments that integrate with systemd
)

echo "${GREEN}:: ${BWHITE}Installing Hyprland and its components...${NC}"
$HELPER -S --noconfirm --needed --quiet "${HYPRLAND_PACKAGES[@]}"

echo "${GREEN}:: ${BWHITE}Enabling Hyprland services...${NC}"
systemctl enable --now --user wayland-pipewire-idle-inhibit.service
systemctl enable --user hypridle.service
systemctl enable --user hyprpaper.service
systemctl enable --user waybar.service
