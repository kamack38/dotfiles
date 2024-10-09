local term = "kitty"

return {
	--- Default Applications
	default = {
		--- Default terminal emulator
		terminal = term,
		--- Default music client
		music_player = term .. " -e ncmpcpp",
		--- Default text editor
		text_editor = term .. "-e nvim",
		--- Default code editor
		code_editor = "code",
		--- Default web browser
		web_browser = "firefox-developer-edition",
		--- Default file manager
		file_manager = "dolphin",
		--- Default network manager
		network_manager = term .. " -e nmtui",
		--- Default lock screen cmd
		lock_screen_cmd = term .. "-e 'betterlockscreen -l'",
		-- Default app launcher
		app_launcher = "rofi -show drun -no-default-config -config " .. os.getenv("HOME") .. "/.config/rofi/main.rasi",
		--- Default bluetooth manager
		-- bluetooth_manager = "blueman-manager",
		--- Default power manager
		-- power_manager = "xfce4-power-manager",
	},
}
