---------------
-- Window Rules
-- See https://wiki.hypr.land/Configuring/Window-Rules/
---------------

local function rule(name, match, properties)
  properties.name = name
  properties.match = match
  hl.window_rule(properties)
end

-- Workspace placement
rule("discord-4", { class = "^(vesktop|discord)$" }, { workspace = "4 silent" })
rule("beeper-5", { class = "^(Beeper)$" }, { workspace = "5 silent" })

-- Tile rules
rule("neovide-tile", { class = "neovide" }, { tile = true })
rule("spotify-tile", { class = "^(Spotify)$" }, { tile = true })

-- Float rules
rule("windowrule-5", { class = "org.kde.polkit-kde-authentication-agent-1" }, { float = true })

-- rule("windowrule-6", { title = "^(Send File — Dolphin)$" }, { float = true })
rule("dolphin-new-dir", { title = "^(Create New Folder — Dolphin)$" }, { float = true })
rule("bluedevil", { class = "^(org.kde.bluedevilsendfile)$" }, { float = true })
rule("android-emulator", { class = "^(Emulator)$" }, { float = true })

-- Btop - system monitor
rule("btop-system-monitor", { class = "system_monitor" }, {
  float = true, center = true, stay_focused = true, animation = "slide", size = "1000 760",
})

-- Waybar - package update
rule("waybar-package-update", { class = "package_update" }, {
  float = true, center = true, animation = "slide",
})

-- Firefox - Picture-in-Picture
rule("ff-pip", {
  class = "^(firefox-developer-edition)$",
  title = "^(Picture-in-Picture)$",
}, {
  float = true, move = "((monitor_w*1)-window_w-20) 0", pin = true,
})

-- Firefox - password prompt
rule("ff-password", { title = "^(Password Required)(.*)" }, {
  float = true, stay_focused = true, size = "500 150", center = true,
})

rule("wlogout-full", { class = "wlogout" }, {
  float = true, fullscreen = true, no_anim = true, stay_focused = true,
})

rule("xwayland-bridge", { class = "^(xwaylandvideobridge)$" }, {
  opacity = "0.0 override 0.0 override",
  no_anim = true,
  no_focus = true,
  no_initial_focus = true,
})
rule("msoffice", { class = "^(Microsoft (Excel|Access))$" }, {
  no_anim = true, no_blur = true, border_size = 0, no_shadow = true,
})
rule("steam", { class = "^(steam)$" }, { no_blur = true })
rule("steam-app", { class = "^steam_app_.*" }, { workspace = 5 })
rule("freecad", { class = "^(org.freecad.FreeCAD)$" }, {
  no_blur = true, opacity = "1.0 override 1.0 override",
})

------------------
-- Workspace Rules
-- See https://wiki.hypr.land/configuring/core/rules/workspace-rules/
------------------

-- Smart Gaps / No gaps when only
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
rule("windowrule-21", { float = false, workspace = "w[tv1]" }, { border_size = 0, rounding = 0 })
rule("windowrule-22", { float = false, workspace = "f[1]" }, { border_size = 0, rounding = 0 })

--------------
-- Layer Rules
-- See https://wiki.hypr.land/configuring/core/rules/layer-rules/
--------------
hl.curve("easeOut", { type = "bezier", points = { { 0.33, 1 }, { 0.68, 1 } } })
hl.animation({ leaf = "layers", enabled = true, speed = 2, bezier = "easeOut" })
hl.layer_rule({ name = "dunst-notifications", animation = "slide", match = { namespace = "notifications" } })
hl.layer_rule({ name = "rofi-launcher", animation = "popin", match = { namespace = "rofi" } })
hl.layer_rule({
  name = "vicinae-blur", blur = true, ignore_alpha = 0, match = { namespace = "vicinae" },
})
