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

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

M.ui = {
  theme = "onedark",
  transparency = true,
  theme_toggle = { "onedark", "everforest" },
}

M.plugins = require "custom.plugins"

M.mappings = require "custom.mappings"

return M
