local awful = require("awful")
local beautiful = require("beautiful")
local ruled = require("ruled")

ruled.client.connect_signal("request::rules", function()
	--- Global
	ruled.client.append_rule({
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen
		}
	})

	--- Floating
	ruled.client.append_rule({
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer"
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			}
		}, properties = { floating = true }
	})

	--- Titlebar rules
	ruled.client.append_rule({
		rule_any = {
			type = { "normal", "dialog" }
		},
		properties = {
			titlebars_enabled = false
		}
	})

	--- Polybar fix
	ruled.client.append_rule({
		rule_any = {
			class = { "Polybar" }
		},
		properties = {
			border_width = 0,
			focusable = false
		}
	})

	--- Ulauncher fix
	ruled.client.append_rule({
		rule_any = {
			class = { "Ulauncher" }
		},
		properties = {
			border_width = 0,
			titlebars_enabled = false,
			ontop = true
		}
	})
end)
