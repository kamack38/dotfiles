local home = os.getenv("HOME")
local scripts = home .. "/.config/hypr/scripts"

------------
-- Constants
------------
return {
  scripts = scripts,
  main_mod = "SUPER",
  browser = "firefox-developer-edition",
  private_browser = "firefox-developer-edition --private-window",
  powermenu = "killall wlogout || wlogout",
  term = "kitty",
  file_browser = "dolphin",
  system_monitor = "kitty --class system_monitor -e btop",
  cheatsheet = 'kitty --class system_monitor -e sh -c "cat ' ..
      home .. '/Documents/GitHUB/Essentials.wiki/{Neovim.md,Linux.md} | glow -p -w 90"',

  -- Volume
  raise_volume = "volume set-volume @DEFAULT_AUDIO_SINK@ 2%+",
  lower_volume = "volume set-volume @DEFAULT_AUDIO_SINK@ 2%-",
  mute_audio = "volume set-mute @DEFAULT_AUDIO_SINK@ toggle",
  toggle_mic_mute = "microphone set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
  raise_mic_volume = "microphone set-volume @DEFAULT_AUDIO_SOURCE@ 2%+",
  lower_mic_volume = "microphone set-volume @DEFAULT_AUDIO_SOURCE@ 2%-",

  -- Brightness
  increase_brightness = "brightness set 5%+ -q",
  decrease_brightness = "brightness set 5%- -q",
}
