#!/usr/bin/env sh

HYPRGAMEMODE=${1:-$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')}
KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"

if [ $HYPRGAMEMODE = 1 ]; then
	# Disable unnecessary decorations
	hyprctl --batch "\
		keyword animations:enabled 0;\
		keyword decoration:shadow:enabled 0;\
		keyword decoration:blur:enabled 0;\
		keyword general:gaps_in 0;\
		keyword general:gaps_out 0;\
		keyword general:border_size 1;\
		keyword decoration:rounding 0"

	# Switch to a different bar
	~/.config/hypr/scripts/configure_monitors.sh

	# Disable transparency in kitty
	sed -i 's/background_opacity 0.8/background_opacity 1/' "$KITTY_CONFIG"

	notify-send "Enabled gamemode"
	exit
fi
sed -i 's/background_opacity 1/background_opacity 0.8/' "$KITTY_CONFIG"
hyprctl reload
