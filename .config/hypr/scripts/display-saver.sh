hyprctl monitors -j |
	jq -r '.[] |
	select(.disabled | not) |
	"\(.name),\(.width)x\(.height)@60,\(.x)x\(.y),\(.scale),transform,\(.transform)"' |
	while read -r cfg; do
		hyprctl keyword monitor "$cfg"
	done

echo 2 | sudo tee /sys/class/drm/card*-eDP-*/amdgpu/panel_power_savings
echo "Current power saving level is: $(cat /sys/class/drm/card*-eDP-*/amdgpu/panel_power_savings)"
