hyprctl monitors -j |
	jq -r '.[] |
        select(.disabled | not) |
        "hl.monitor({ output = \"\(.name)\", mode = \"\(.width)x\(.height)@60\", position = \"\(.x)x\(.y)\", scale = \(.scale), transform = \(.transform) })"' |
	while read -r cfg; do
		hyprctl eval "$cfg"
	done

echo 2 | sudo tee /sys/class/drm/card*-eDP-*/amdgpu/panel_power_savings
echo "Current power saving level is: $(cat /sys/class/drm/card*-eDP-*/amdgpu/panel_power_savings)"
