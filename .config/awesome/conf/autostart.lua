local awful = require("awful")

local function autostart_apps()
	--- Compositor
	awful.spawn.with_shell("picom --experimental-backends")
	--- Bar
	awful.spawn.with_shell("~/.config/polybar/launch.sh")
	--- Launcher
	awful.spawn.with_shell("env GDK_BACKEND=x11 /usr/bin/ulauncher --hide-window --no-window-shadow")
end

autostart_apps()
