----------
-- Monitor
-- See https://wiki.hypr.land/configuring/core/monitors/
--
-- Available modes: preferred, highres, highrr, maxwidth
----------

hl.monitor({ output = "", mode = "highrres", position = "auto", scale = "1" })

-- Rotate 90deg
-- hl.monitor({ output = "DP-1", mode = "highrr", position = "auto", scale = 1, transform = 1 })

-- Enable vrr
-- hl.monitor({ output = "DP-1", mode = "highrr", position = "auto", scale = 1, vrr = 1 })

-- Mirror
-- hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 1, mirror = "eDP-1" })

-- Disable built-in monitor
-- hl.monitor({ output = "eDP-1", disabled = true })
