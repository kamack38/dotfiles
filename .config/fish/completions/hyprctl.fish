# fish completion for hyprctl
# command to convert markdown table: wl-paste | sed 's/| //; s/ |.*//' | tr '\n' ' ' | wl-copy

function __hyprctl_get_clients_addresses
  hyprctl clients -j | jq '.[]|[.address]|@tsv' -r | sed 's/^/address:/'
end

# Subcommands
set -l subcommands monitors workspaces clients activewindow layers devices dispatch keyword version kill splash hyprpaper reload setcursor getoption cursorpos switchxkblayout seterror setprop plugin
set -l infocommands monitors workspaces clients activewindow layers devices activewindow layers devices version splash getoption cursorpos

set -l hyprland_sections general decoration animations input input_touchpad input_touchdevice gestures misc binds debug

set -l general_options sensitivity border_size no_border_on_floating gaps_in gaps_out col.inactive_border col.active_border col.group_border col.group_border_active cursor_inactive_timeout layout no_cursor_warps no_focus_fallback apply_sens_to_raw resize_on_border extend_border_grab_area hover_icon_on_border
set -l decoration_options rounding multisample_edges active_opacity inactive_opacity fullscreen_opacity blur blur_size blur_passes blur_ignore_opacity blur_new_optimizations blur_xray drop_shadow shadow_range shadow_render_power shadow_ignore_window col.shadow col.shadow_inactive shadow_offset shadow_scale dim_inactive dim_strength dim_special dim_around screen_shader
set -l animations_options enabled
set -l input_options kb_model kb_layout kb_variant kb_options kb_rules kb_file numlock_bydefault repeat_rat repeat_delay sensitivity accel_profile force_no_accel left_handed scroll_method scroll_button natural_scroll follow_mouse float_switch_override_focus
set -l input_touchpad_options disable_while_typing natural_scroll scroll_factor middle_button_emulation tap_button_map clickfinger_behavior tap-to-click drag_lock
set -l input_touchdevice_options transform output
set -l gestures_options workspace_swipe workspace_swipe_fingers workspace_swipe_distance workspace_swipe_invert workspace_swipe_min_speed_to_force workspace_swipe_create_new workspace_swipe_forever workspace_swipe_numbered
set -l misc_options disable_hyprland_logo disable_splash_rendering vfr vrr mouse_move_enables_dpms key_press_enables_dpms always_follow_on_dnd layers_hog_keyboard_focus animate_manual_resizes animate_mouse_windowdragging disable_autoreload enable_swallow swallow_regex swallow_exception_regex focus_on_activate no_direct_scanout hide_cursor_on_touch mouse_move_focuses_monitor suppress_portal_warnings render_ahead_of_time render_ahead_safezone cursor_zoom_factor curzor_zoom_rigid
set -l binds_options pass_mouse_when_bound scroll_event_delay workspace_back_and_forth allow_workspace_cycles focus_preferred_method
set -l debug_options overlay damage_blink disable_logs disable_time damage_tracking enable_stdout_logs manual_crash

# Disable file completions for the entire command
complete -c hyprctl -f

## Subcommands
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "monitors" -d "show connected monitors"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "workspaces" -d "show all workspaces"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "clients" -d "show all clients"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "activewindow" -d "show active window"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "layers" -d "show layers"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "devices" -d "show connected devices"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "dispatch" -d "call a keybind dispatcher"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "keyword" -d "call a config keyword dynamically"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "version" -d "print hyprctl version"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "kill" -d "enter kill mode (press on app window to kill)"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "splash" -d "print the current random splash"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "hyprpaper" -d ""
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "reload" -d "force reload the config"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "setcursor" -d "sets the cursor theme and reloads the cursor manager."
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "getoption" -d "gets the config option status"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "cursorpos" -d "gets the current cursor pos in global layout coordinates"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "switchxkblayout" -d "sets the xkb layout index for a keyboard."
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "seterror" -d "sets the hyprctl error string"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "setprop" -d "sets a window prop"
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -a "plugin" -d "lists, loads or unloads plugins"

## Global options
complete -c hyprctl -n "not __fish_seen_subcommand_from $subcommands" -l "batch" -d "specify a batch of commands to execute"
complete -c hyprctl -n "__fish_seen_subcommand_from $infocommands" \
    -s j -d "Print output in JSON"

### dispatch
set -l dispatchers exec execr pass killactive closewindow workspace movetoworkspace movetoworkspacesilent togglefloating fullscreen fakefullscreen dpms pin movefocus movewindow centerwindow resizeactive resizewindowpixel cyclenext swapnext focuswindow focusmonitor splitratio toggleopaque movecursortocorner workspaceopt renameworkspace exit forcerendererreload movecurrentworkspacetomonitor moveworkspacetomonitor swapactiveworkspaces bringactivetop togglespecialworkspace focussurgetolast togglegroup changegroupactive focuscurrentrolast lockgroups moveintogroup moveoutgroup
complete -c hyprctl -n "__fish_seen_subcommand_from dispatch; and not __fish_seen_subcommand_from $dispatchers" -a "$dispatchers"

### getoption
set -l config_options

for section in $hyprland_sections
  for option in  (eval "printf '%s\n' \$$section[1]_options")
    set -a config_options (string replace _ ':' $section):$option
  end
end

complete -c hyprctl -n "__fish_seen_subcommand_from getoption; and not __fish_seen_subcommand_from $config_options" -a "$config_options"

### keyword
set -l keyword_options $config_options monitor bind exec exec-once source bruls
complete -c hyprctl -n "__fish_seen_subcommand_from keyword; and not __fish_seen_subcommand_from $keyword_options" -a "$keyword_options"

### setprop
complete -c hyprctl -n "__fish_seen_subcommand_from setprop; and not __fish_seen_subcommand_from (__hyprctl_get_clients_addresses)" -a "(__hyprctl_get_clients_addresses)"

#### props
set -l setprop_props animation_style rounding forcenoblur forceopaque forceopqueoverriden forceallowsinput forcenoanims forcenoshadow widnowdancecompat nomaxsize dimaround alphaoverride alpha alphainactiveoverrdie alphainactive activebordercolor inactivebordercolor

complete -c hyprctl -n "__fish_seen_subcommand_from setprop; and __fish_seen_subcommand_from (__hyprctl_get_clients_addresses); and not __fish_seen_subcommand_from $setprop_props" -a "$setprop_props"
complete -c hyprctl -n "__fish_seen_subcommand_from setprop; and __fish_seen_subcommand_from (__hyprctl_get_clients_addresses); and __fish_seen_subcommand_from $setprop_props" -a "lock"

### plugin
set -l plugin_args list load unload

complete -c hyprctl -n "__fish_seen_subcommand_from plugin; and not __fish_seen_subcommand_from $plugin_args" -a "list" -d "Show loaded plugins"
complete -c hyprctl -n "__fish_seen_subcommand_from plugin; and not __fish_seen_subcommand_from $plugin_args" -a "load" -d "Load plugin by path"
complete -c hyprctl -n "__fish_seen_subcommand_from plugin; and not __fish_seen_subcommand_from $plugin_args" -a "unload" -d "Unload plugin by path"

complete -c hyprctl -n "__fish_seen_subcommand_from plugin; and __fish_seen_subcommand_from unload load" -F

