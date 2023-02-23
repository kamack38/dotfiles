local M = {}
local opt = vim.opt

if vim.fn.has "win32" == 1 then
  opt.shell = "pwsh.exe -nol"
  opt.shellcmdflag = "-nop -c"
  opt.shellquote = '"'
  opt.shellxquote = ""
  opt.shellpipe = "| Out-File -Encoding UTF8 %s"
  opt.shellredir = "| Out-File -Encoding UTF8 %s"
end

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 20

M.ui = {
  theme = "onedark",
  transparency = true,
  theme_toggle = { "onedark", "doomchad" },
}

M.plugins = require "custom.plugins"

M.mappings = require "custom.mappings"

return M
