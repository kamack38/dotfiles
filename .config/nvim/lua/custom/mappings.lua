local M = {}

M.truzen = {
  n = {
    ["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "   truzen ataraxis" },
    ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "   truzen minimal" },
    ["<leader>tf"] = { "<cmd> TZFocus <CR>", "   truzen focus" },
    ["<leader>tn"] = { "<cmd> TZNarrow <CR>", "   truzen narrow" },
  },
}

M.telescope = {
  n = {
    ["<leader>fp"] = { "<cmd> Telescope media_files <CR>", "  find media" },
    ["<leader>wk"] = { "<cmd> Telescope keymaps <CR>", "find keys" },
  },
}

M.coderunner = {
  n = {
    ["<F7>"] = { "<cmd> RunCode <CR>", "Run code" },
  },
}

M.trouble = {
  n = {
    ["<C-S-m>"] = { "<cmd> TroubleToggle <CR>", "Show diagnostics" },
  },
}

M.codeactions = {
  n = {
    ["<C-space>"] = { "<cmd> CodeActionMenu <CR>", "Show code action menu" },
  },
}

M.neovim = {
  n = {
    ["<A-k>"] = { "<cmd> m-2 <CR>", "move curent line up" },
    ["<A-j>"] = { "<cmd> m+ <CR>", "move curent line down" },
    ["<A-S-j>"] = { "<cmd> yank <CR> p", "copy curent line down" },
    ["<A-S-k>"] = { "<cmd> yank <CR> P", "copy curent line up" },
  },
}

return M
