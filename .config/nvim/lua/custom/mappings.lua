local M = {}

M.truzen = {
  n = {
    ["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "  Truzen ataraxis" },
    ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "  Truzen minimal" },
    ["<leader>tf"] = { "<cmd> TZFocus <CR>", "  Truzen focus" },
    ["<leader>tn"] = { "<cmd> TZNarrow <CR>", "  Truzen narrow" },
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
    ["<A-j>"] = { "<cmd> m+ <CR>", "  Move curent line down" },
    ["<A-S-j>"] = { "<cmd> yank <CR> p", "  Copy curent line down" },
    ["<A-S-k>"] = { "<cmd> yank <CR> P", "  Copy curent line up" },
  },
}

return M
