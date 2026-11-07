---------
-- Events
---------

local command = hl.dsp.exec_cmd

hl.on("monitor.added", function()
  command("systemctl --user restart waybar")
end)
hl.on("monitor.removed", function()
  command("systemctl --user restart waybar")
end)
