local M = {}
local opt = vim.opt

local override = require "custom.plugins.override"
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
   theme = "onedark",
   transparency = true,
}

M.plugins = {
   override = {
      ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
      ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
      ["williamboman/mason.nvim"] = override.mason,
   },

   default_plugin_config_replace = {},

   user = userPlugins,
}

M.mappings = require "custom.mappings"

return M
