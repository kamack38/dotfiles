--------
-- Utils
--------

local M = {}

-- Move current window to special workspace if not already.
-- Otherwise move to current active workspace
function M.toggle_in_special()
  local w = hl.get_active_window()
  if not w then return end

  if w.workspace.id ~= nil then
    hl.dispatch(hl.dsp.window.move({ workspace = "special" }))
  else
    hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace().id }))
  end
end

-- Toggle zoom
function M.toggle_zoom()
  local current = hl.get_config("cursor.zoom_factor")

  if current == nil or current <= 1 then
    hl.config({ cursor = { zoom_factor = 2 } })
  else
    hl.config({ cursor = { zoom_factor = 1 } })
  end
end

return M
