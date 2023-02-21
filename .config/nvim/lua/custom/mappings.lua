local M = {}

M.truzen = {
  n = {
    ["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "  Truzen ataraxis" },
    ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "  Truzen minimal" },
    ["<leader>tf"] = { "<cmd> TZFocus <CR>", "  Truzen focus" },
    ["<leader>tn"] = { "<cmd> TZNarrow <CR>", "  Truzen narrow" },
  },
}

M.dashboard = {
  n = {
    ["<leader>db"] = { "<cmd> Alpha <CR>", "舘  Show dashboard" },
  },
}

M.telescope = {
  n = {
    ["<leader>fp"] = { "<cmd> Telescope media_files <CR>", "  Find media" },
    ["<leader>wk"] = { "<cmd> Telescope keymaps <CR>", "  Find keys" },
  },
}

M.coderunner = {
  n = {
    ["<F7>"] = { "<cmd> RunFile <CR>", "  Run code" },
  },
}

M.trouble = {
  n = {
    ["<C-S-m>"] = { "<cmd> TroubleToggle <CR>", "  Show diagnostics" },
  },
}

M.codeactions = {
  n = {
    ["<C-space>"] = { "<cmd> CodeActionMenu <CR>", "  Show code action menu" },
  },
}

M.neovim = {
  n = {
    ["<A-k>"] = { "<cmd> m-2 <CR>", "  Move curent line up" },
    ["<A-j>"] = { "<cmd> m+ <CR>", "  Move curent line down" },
    ["<A-S-j>"] = { "<cmd> t. <CR>", "  Copy curent line down" },
    ["<A-S-k>"] = { "<cmd> t- <CR>", "  Copy curent line up" },
  },
}

M.leap = {
  n = {
    ["<leader>s"] = {
      function()
        require("leap").leap { target_windows = { vim.fn.win_getid() } }
      end,
      "  Jump to search",
    },
    ["<leader>S"] = {
      function()
        require("leap").leap { offset = -1, target_windows = { vim.fn.win_getid() } }
      end,
      "  Jump till search",
    },
  },
}

return M
