local c = require("./modules/constants")
local u = require("./modules/utils")

-- Shorthands
local command = hl.dsp.exec_cmd
local bind = hl.bind

local function focus(direction)
  return hl.dsp.focus({ direction = direction })
end

local function move(direction)
  return hl.dsp.window.move({ direction = direction })
end

--------
-- Binds
-- See https://wiki.hypr.land/configuring/core/binds/
-- See https://wiki.hypr.land/configuring/core/dispatchers/
--------
bind(c.main_mod .. " + SHIFT + Q", hl.dsp.exit())
bind(c.main_mod .. " + SHIFT + R", hl.dsp.reload_config())
bind(c.main_mod .. " + F1", command(c.scripts .. "/gamemode.sh"))
bind(c.main_mod .. " + SHIFT + Z", command("toggle_zoom"))

-- Apps
bind(c.main_mod .. " + grave", command(c.term))
bind(c.main_mod .. " + E", command(c.file_browser))
bind("XF86MyComputer", command(c.file_browser))
bind(c.main_mod .. " + B", command(c.browser))
bind("XF86HomePage", command(c.browser))
bind(c.main_mod .. " + SHIFT + B", command(c.private_browser))
bind(c.main_mod .. " + SHIFT + M", command(c.system_monitor))
bind(c.main_mod .. " + SHIFT + V", command(c.cheatsheet))
bind(c.main_mod .. " + SHIFT + C", command("hyprpicker"))
bind(c.main_mod .. " + Escape", command(c.powermenu))

-- Screenshot
bind("Print", command("grimblast --notify --cursor copysave output"))
bind(c.main_mod .. " + SHIFT + S", command("grimblast --notify copysave area"))

-- Window state
bind(c.main_mod .. " + X", hl.dsp.window.kill())
bind(c.main_mod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
bind(c.main_mod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(c.main_mod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "toggle" }))
bind(c.main_mod .. " + M", hl.dsp.window.fullscreen({ mode = 1 }))
bind(c.main_mod .. " + T", hl.dsp.window.pin())
bind(c.main_mod .. " + P", hl.dsp.window.pseudo())
bind(c.main_mod .. " + S", hl.dsp.layout("togglesplit"))

-- Resizing windows
bind(c.main_mod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
bind(c.main_mod .. " + SHIFT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
bind(c.main_mod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
bind(c.main_mod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))

-- Cycling through windows
bind("ALT + TAB", hl.dsp.window.cycle_next())
bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next({ next = false }))

-- Moving window
bind(c.main_mod .. " + MOD5 + H", move("left"))
bind(c.main_mod .. " + MOD5 + left", move("left"))
bind(c.main_mod .. " + MOD5 + J", move("down"))
bind(c.main_mod .. " + MOD5 + down", move("down"))
bind(c.main_mod .. " + MOD5 + K", move("up"))
bind(c.main_mod .. " + MOD5 + up", move("up"))
bind(c.main_mod .. " + MOD5 + L", move("right"))
bind(c.main_mod .. " + MOD5 + right", move("right"))

-- Moving window through monitors
bind(c.main_mod .. " + SHIFT + H", hl.dsp.window.move({ monitor = "-1" }))
bind(c.main_mod .. " + SHIFT + L", hl.dsp.window.move({ monitor = "+1" }))

-- Focus
bind(c.main_mod .. " + Tab", hl.dsp.window.cycle_next())
bind(c.main_mod .. " + left", focus("left"))
bind(c.main_mod .. " + H", focus("left"))
bind(c.main_mod .. " + right", focus("right"))
bind(c.main_mod .. " + L", focus("right"))
bind(c.main_mod .. " + up", focus("up"))
bind(c.main_mod .. " + K", focus("up"))
bind(c.main_mod .. " + down", focus("down"))
bind(c.main_mod .. " + J", focus("down"))

-- Focusing monitors
bind(c.main_mod .. " + SHIFT + K", hl.dsp.focus({ monitor = "+1" }))
bind(c.main_mod .. " + SHIFT + J", hl.dsp.focus({ monitor = "-1" }))

-- Workspaces
for i = 1, 10 do
  local key = i % 10
  bind(c.main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  bind(c.main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Cycling through workspaces
bind(c.main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind(c.main_mod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
bind(c.main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
bind(c.main_mod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

-- Moving workspaces
bind(c.main_mod .. " + CTRL + h", hl.dsp.workspace.move({ monitor = "l" }))
bind(c.main_mod .. " + CTRL + l", hl.dsp.workspace.move({ monitor = "r" }))

-- Swapping workspaces
bind(c.main_mod .. " + u", hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" }))

-- Resizing window with the mouse
bind(c.main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(c.main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Window groups
bind(c.main_mod .. " + G", hl.dsp.group.toggle())
bind(c.main_mod .. " + N", hl.dsp.group.next())
bind(c.main_mod .. " + SHIFT + N", hl.dsp.group.prev())
bind(c.main_mod .. " + SHIFT + Escape", hl.dsp.group.move_window())

-- Special workspaces
bind(c.main_mod .. " + C", u.toggle_in_special)
bind(c.main_mod .. " + Z", hl.dsp.workspace.toggle_special())

-- Brightness control
bind("XF86MonBrightnessUp", command(c.increase_brightness), { repeating = true })
bind("XF86MonBrightnessDown", command(c.decrease_brightness), { repeating = true })

-- Audio keybindings
local player_binds = {
  { key = "XF86AudioPlay",                cmd = "play-pause" },
  { key = "XF86AudioPause",               cmd = "pause" },
  { key = "XF86AudioStop",                cmd = "stop" },
  { key = "XF86AudioNext",                cmd = "next" },
  { key = "XF86AudioPrev",                cmd = "previous" },
  { key = "SHIFT + XF86AudioNext",        cmd = "position 5+",  repeating = true },
  { key = "SHIFT + XF86AudioPrev",        cmd = "position 5-",  repeating = true },
  { key = "SHIFT + XF86AudioRaiseVolume", cmd = "volume 0.02+", repeating = true },
  { key = "SHIFT + XF86AudioLowerVolume", cmd = "volume 0.02-", repeating = true },
}

for _, b in ipairs(player_binds) do
  bind(b.key, command("playerctl " .. b.cmd .. " && mpris-noti"),
    { locked = true, repeating = b.repeating })
end

bind("SHIFT + XF86AudioPlay", command("mpris-noti"))
bind("XF86AudioMute", command(c.mute_audio))
bind("XF86AudioRaiseVolume", command(c.raise_volume), { locked = true, repeating = true })
bind("XF86AudioLowerVolume", command(c.lower_volume), { locked = true, repeating = true })

-- Microphone
bind("CTRL + XF86AudioRaiseVolume", command(c.raise_mic_volume), { locked = true, repeating = true })
bind("CTRL + XF86AudioLowerVolume", command(c.lower_mic_volume), { locked = true, repeating = true })
bind("XF86AudioMicMute", command(c.toggle_mic_mute))
bind("SHIFT + XF86AudioMicMute",
  command(
    'pactl list sources | grep -oP "Name: \\S+" | grep "input" | cut -d" " -f2 | xargs -I{} pactl set-source-mute {} false'))

-- Launch keybindings
bind("XF86Launch4", command(c.scripts .. "/asus_profile.sh"))
