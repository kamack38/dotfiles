local awful = require("awful")

local function launch_polybar()
	awful.spawn.with_shell("~/.config/polybar/launch.sh")
	for _, tag in ipairs(root.tags()) do
		tag:connect_signal("property::layout", function(t)
			awful.spawn.with_shell("polybar-msg action awesomewm hook 0")
		end)
	end
	for _, tag in ipairs(root.tags()) do
		tag:connect_signal("property::selected", function(t)
			awful.spawn.with_shell("polybar-msg action awesomewm hook 0")
		end)
	end
end

local function autostart_apps()
	--- Compositor
	awful.spawn.with_shell("picom")
	--- Bar
	launch_polybar()
	--- Launcher
	awful.spawn.with_shell("env GDK_BACKEND=x11 /usr/bin/ulauncher --hide-window --no-window-shadow")
end

autostart_apps()
