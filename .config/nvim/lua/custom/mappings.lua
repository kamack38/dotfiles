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
    },
}

return M
