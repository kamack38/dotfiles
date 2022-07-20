local awful = require("awful")
local gears = require("gears")
require("awful.autofocus")
local beautiful = require("beautiful")
local apps = require("conf.apps")
local hotkeys_popup = require("awful.hotkeys_popup")

myawesomemenu = {
    { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "Manual", apps.default.terminal .. " -e man awesome" },
    { "Edit config", apps.default.text_editor .. " " .. awesome.conffile },
    { "Restart", awesome.restart },
    { "Quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "Open terminal", apps.default.terminal }
}
})

root.buttons(gears.table.join(
    awful.button({}, 3, function() mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))
