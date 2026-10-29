local u = require("./modules/utils")

-----------
-- Gestures
-- See https://wiki.hypr.land/configuring/core/binds/gestures/
------------

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = function()
    hl.dispatch(hl.dsp.window.cycle_next())
  end
})
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "pinchout", action = "close" })
hl.gesture({
  fingers = 3,
  direction = "vertical",
  action = "special"
})
hl.gesture({
  fingers = 4,
  direction = "vertical",
  action = u.toggle_in_special
})
