local st_modules = require "nvchad_ui.statusline.modules"

local function LSP_Diagnostics_Click(minwid, clicks, button, mods)
  -- your impl
end

return {
  LSP_Diagnostics = function()
    return "%@LSP_Diagnostics_Click@" .. st_modules.LSP_Diagnostics() .. "%X"
  end,
}
