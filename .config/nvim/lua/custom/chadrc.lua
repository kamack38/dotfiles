local M = {}
local opt = vim.opt

local plugin_conf = require "custom.plugins.configs"
local userPlugins = require "custom.plugins"

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

   override = {
      ["kyazdani42/nvim-tree.lua"] = plugin_conf.nvimtree,
      ["nvim-treesitter/nvim-treesitter"] = plugin_conf.treesitter,
   },

   default_plugin_config_replace = {},

   user = userPlugins,
}

return M
