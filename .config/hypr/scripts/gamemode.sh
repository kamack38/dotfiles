#!/usr/bin/env sh

HYPRGAMEMODE=${1:-$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')}
KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"

if [ $HYPRGAMEMODE = 1 ]; then
	# Disable unnecessary decorations
	hyprctl eval '
hl.config({
  animations = { enabled = false },
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 1,
  },
  decoration = {
    rounding = 0,
    blur = { enabled = false },
    shadow = { enabled = false },
  },
})
'

	# Restart bar
	systemctl restart --user waybar

	# Disable transparency in kitty
	sed -i 's/background_opacity 0.8/background_opacity 1/' "$KITTY_CONFIG"

	notify-send "Enabled gamemode"
	exit
fi
sed -i 's/background_opacity 1/background_opacity 0.8/' "$KITTY_CONFIG"
hyprctl reload
