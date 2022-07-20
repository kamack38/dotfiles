local awful = require("awful")

--- Tags
--- ~~~~
awful.util.tagnames = { " Main ", " Secondary ", " DEV ", " Social ", " Gaming ", " Misc " }
screen.connect_signal("request::desktop_decoration", function(s)
	--- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])
end)
