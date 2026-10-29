------------
-- Autostart
-- See https://wiki.hypr.land/configuring/core/autostart/
------------

hl.on("hyprland.start", function()
  hl.exec_cmd("runapp wl-paste --type text --watch cliphist store")
  hl.exec_cmd("runapp wl-paste --type image --watch cliphist store")
end)
