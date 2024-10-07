-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  ["@comment"] = { italic = true },
  Comment = { italic = true },
  TelescopeSelection = { bg = "#353A46", fg = "#abb2bf" },
  IblScopeChar = { fg = "#9196a1" },
}

M.add = {
  VisualWhitespace = { fg = "#565c64", bg = "#170a1d" },
}

return M
