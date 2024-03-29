---------------------------
-- Default awesome theme --
---------------------------
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

--- Special
theme.transparent = "#00000000"

--- Theme
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/kamack38"
theme.wallpaper = os.getenv("HOME") .. "/Pictures/Wallpapers/Lake Carhuacocha - Cath Simard.png"
theme.fg_normal = "#ffffff"
theme.fg_focus = "#A77AC4"
theme.fg_urgent = "#b74822"
theme.bg_normal = "#282a36"
theme.bg_focus = "#FF79C6"
theme.bg_urgent = "#3F3F3F"
theme.taglist_fg_focus = "#282a36"
theme.tasklist_bg_focus = "#000000"
theme.tasklist_fg_focus = "#A77AC4"
theme.border_width = 2
theme.border_normal = "#282a36"
theme.border_focus = "#F07178"
theme.border_marked = "#CC9393"
theme.titlebar_bg_focus = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_focus
theme.menu_height = 20
theme.menu_width = 140
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = 4
theme.corner_radious = 10

--- Bling window switcher
theme.window_switcher_widget_bg = theme.bg_normal
theme.window_switcher_widget_border_width = theme.border_width
theme.window_switcher_widget_border_radius = 10
theme.window_switcher_widget_border_color = "#F0F0F0AA"
theme.window_switcher_clients_spacing = 20
theme.window_switcher_client_icon_horizontal_spacing = 5
theme.window_switcher_client_width = 150
theme.window_switcher_client_height = 250
theme.window_switcher_client_margins = 10
theme.window_switcher_thumbnail_margins = 5
theme.thumbnail_scale = false
theme.window_switcher_name_margins = 10
theme.window_switcher_name_valign = "center"
theme.window_switcher_name_forced_width = 200
theme.window_switcher_name_font = "sans 11"
theme.window_switcher_name_normal_color = theme.fg_normal
theme.window_switcher_name_focus_color = theme.fg_focus
theme.window_switcher_icon_valign = "center"
theme.window_switcher_icon_width = 40

--- Fonts
theme.font = "sans 8"
theme.font_name = "Roboto "

--- Notifications
theme.notification_font = theme.font_name
theme.notification_width = 325
theme.notification_height = 125
theme.notification_icon_size = 115
theme.notification_border_color = "#1e1e2e"
theme.notification_fg = "#f5e0dc"

--- Icons
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.awesome_icon = theme.dir .. "/icons/awesome.png"
theme.taglist_squares_sel = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile = theme.dir .. "/icons/tile.png"
theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv = theme.dir .. "/icons/fairv.png"
theme.layout_fairh = theme.dir .. "/icons/fairh.png"
theme.layout_spiral = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle = theme.dir .. "/icons/dwindle.png"
theme.layout_max = theme.dir .. "/icons/max.png"
theme.layout_fullscreen = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.dir .. "/icons/magnifier.png"
theme.layout_floating = theme.dir .. "/icons/floating.png"
theme.widget_ac = theme.dir .. "/icons/ac.png"
theme.widget_battery = theme.dir .. "/icons/battery.png"
theme.widget_battery_low = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem = theme.dir .. "/icons/mem.png"
theme.widget_cpu = theme.dir .. "/icons/cpu.png"
theme.widget_temp = theme.dir .. "/icons/temp.png"
theme.widget_net = theme.dir .. "/icons/net.png"
theme.widget_hdd = theme.dir .. "/icons/hdd.png"
theme.widget_music = theme.dir .. "/icons/note.png"
theme.widget_music_on = theme.dir .. "/icons/note.png"
theme.widget_music_pause = theme.dir .. "/icons/pause.png"
theme.widget_music_stop = theme.dir .. "/icons/stop.png"
theme.widget_vol = theme.dir .. "/icons/vol.png"
theme.widget_vol_low = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail = theme.dir .. "/icons/mail.png"
theme.widget_mail_on = theme.dir .. "/icons/mail_on.png"
theme.widget_task = theme.dir .. "/icons/task.png"
theme.widget_scissors = theme.dir .. "/icons/scissors.png"
theme.widget_weather = theme.dir .. "/icons/dish.png"
theme.titlebar_close_button_focus = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
