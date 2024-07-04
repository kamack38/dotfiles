-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = { italic = true },
  ["@comment"] = { italic = true },
  TelescopeSelection = { bg = "#353A46", fg = "#abb2bf" },
}

return M
