---@type ChadrcConfig
return {

  ui = {
    theme = "onedark",
    transparency = true,

    hl_override = require("highlights").override,

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
      -- modules = nil,
      -- modules = {
      --   -- The default cursor module is override
      --   cursor = function()
      --     return "%#BruhHl#" .. " bruh " -- the highlight group here is BruhHl,
      --   end,
      -- },
    },

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
  },

  term = {
    sizes = {
      vsp = 0.5,
      sp = 0.3,
    },
  },

  lsp = {
    signature = true,
  },

  cheatsheet = {
    theme = "grid", -- simple/grid
    excluded_groups = { ":help (i)", ":help (x)", ":help", "Comment (v)", "Spider" },
  },

  base46 = {
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
  },
}
