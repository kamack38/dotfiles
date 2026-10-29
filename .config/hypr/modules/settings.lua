------------
-- Variables
-- See https://wiki.hypr.land/configuring/core/config-options/
------------

hl.config({
  -- See https://wiki.hypr.land/configuring/core/config-options/#input
  input = {
    kb_layout = "pl",
    follow_mouse = 1,
    accel_profile = "flat",
    touchpad = { natural_scroll = true },
    sensitivity = 0,
    tablet = { output = "current" },
  },

  -- See https://wiki.hypr.land/configuring/core/config-options/#cursor
  cursor = {
    use_cpu_buffer = 2,
    no_hardware_cursors = 2,
  },

  -- See https://wiki.hypr.land/configuring/core/config-options/#general
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    col = {
      active_border = { colors = { "rgba(38a3a5ff)", "rgba(57cc99ff)" }, angle = 0 },
      inactive_border = "rgba(595959aa)",
    },
    layout = "dwindle",
    allow_tearing = false,
  },

  -- See https://wiki.hypr.land/configuring/core/config-options/#decoration
  decoration = {
    rounding = 10,
    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },
    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      new_optimizations = true,
    },
  },

  animations = { enabled = true },

  -- See https://wiki.hypr.land/configuring/layouts/dwindle-layout/#config
  dwindle = { preserve_split = true },

  -- See https://wiki.hypr.land/configuring/layouts/master-layout/#config
  master = { new_status = "master" },

  misc = { disable_hyprland_logo = true },

  -- See https://wiki.hypr.land/Configuring/Variables/#group
  group = {
    col = {
      border_active = {
        colors = { "rgba(38a3a5ff)", "rgba(57cc99ff)" }, angle = 0 }
    },
    groupbar = {
      render_titles = false,
      indicator_height = 12,
      rounding = 5,
      round_only_edges = false,
      gaps_in = 5,
      gaps_out = 5,
      col = {
        active = "rgba(50a0e0ff)",
        inactive = "rgba(30303050)",
      },
    },
  },
})

-------------
-- Animations
-- See https://wiki.hypr.land/configuring/core/animations/
-------------
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "default", style = "slide" })
