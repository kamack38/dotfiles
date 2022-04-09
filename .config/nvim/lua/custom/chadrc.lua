local M = {}
local opt = vim.opt

if vim.fn.has('win32') == 1 then
   opt.shell = 'pwsh.exe -nol'
   opt.shellcmdflag = '-nop -c'
   opt.shellquote = '"'
   opt.shellxquote = ''
   opt.shellpipe = '| Out-File -Encoding UTF8 %s'
   opt.shellredir = '| Out-File -Encoding UTF8 %s'
end

M.ui = {
  theme = "onedark"
}
-- NvChad included plugin options & overrides

local userPlugins = require "custom.plugins" -- path to table

M.plugins = {
   status = {
      colorizer = true, -- color RGB, HEX, CSS, NAME color codes
      alpha = true,
      -- snippets = true
   },
   
   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },

   default_plugin_config_replace = {},

   install = userPlugins,
}

return M
