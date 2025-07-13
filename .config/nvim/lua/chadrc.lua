---@type ChadrcConfig
return {
  ui = {
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
  },

  nvdash = {
    load_on_startup = true,

    buttons = {
      { txt = "  Find File", keys = "Spc f f", cmd = "FzfLua files" },
      { txt = "󰈙  Recent Files", keys = "Spc f o", cmd = "FzfLua oldfiles" },
      { txt = "󰈬  Find Word", keys = "Spc f w", cmd = "FzfLua live_grep" },
      { txt = "  New Buffer", keys = "Spc b", cmd = "enew" },
      { txt = "  Marks", keys = "Spc m a", cmd = "FzfLua marks" },
      -- { txt = "  Themes", keys = "Spc t h", cmd = "Telescope themes" },
      { txt = "  Cheatsheet", keys = "Spc c h", cmd = "NvCheatsheet" },

      { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

      {
        txt = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime) .. " ms"
          return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
        end,
        hl = "NvDashFooter",
        no_gap = true,
      },

      { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    },
  },

  term = {
    sizes = {
      vsp = 0.5,
      sp = 0.3,
    },
  },

  colorify = {
    enabled = true,
    mode = "virtual",
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },

  lsp = {
    signature = true,
  },

  cheatsheet = {
    theme = "grid", -- simple/grid
    excluded_groups = { ":help (i)", ":help (x)", ":help", "Comment (v)", "Spider" },
  },

  base46 = {
    theme = "onedark",
    transparency = true,
    hl_override = require("highlights").override,
    hl_add = require("highlights").add,

    integrations = {
      "avante",
      "blankline",
      "cmp",
      "defaults",
      "devicons",
      "git-conflict",
      "git",
      "leap",
      "lsp",
      "mason",
      "nvcheatsheet",
      "nvimtree",
      "semantic_tokens",
      "statusline",
      "syntax",
      "telescope",
      "todo",
      "treesitter",
      "trouble",
      "whichkey",
    },
  },
}
