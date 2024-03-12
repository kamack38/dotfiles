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

-- Folds
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldlevel = 20
-- opt.fillchars = { fold = " ", eob = " " }

-- Other settings
opt.conceallevel = 2

-- Snippets
local config_path = ((os.getenv "XDG_CONFIG_HOME") or os.getenv "HOME" .. "/.config")
vim.g.vscode_snippets_path = config_path .. "/Code/User/snippets"

M.ui = {
  theme = "onedark",
  transparency = true,

  hl_override = {
    Comment = { italic = true },
  },

  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default",
  },

  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    order = nil,
    modules = nil,
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    enabled = true,
    lazyload = false,
    order = { "treeOffset", "buffers", "tabs" },
  },

  nvdash = {
    load_on_startup = true,

    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "  Find Word", "Spc f w", "Telescope live_grep" },
      { "  New Buffer", "Spc n f", "enew" },
      { "  Bookmarks", "Spc b m", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },

  lsp = {
    signature = true,
    semantic_tokens = true,
  },
}

M.base46 = {
  integrations = {
    "blankline",
    "cmp",
    "defaults",
    "devicons",
    "git",
    "lsp",
    "mason",
    "nvcheatsheet",
    "nvdash",
    "nvimtree",
    "statusline",
    "syntax",
    "treesitter",
    "tbline",
    "telescope",
    "whichkey",
  },
}

return M
