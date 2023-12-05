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

  theme_toggle = { "onedark", "doomchad" },

  hl_override = {
    Comment = { italic = true },
  },

  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default",
  },

  nvdash = {
    load_on_startup = true,

    header = {
      "           ▄ ▄                   ",
      "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
      "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
      "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
      "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
      "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
      "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
      "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
      "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
    },

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
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

return M
