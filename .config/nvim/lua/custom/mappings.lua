local M = {}

M.truzen = {
  n = {
    ["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "  Truzen ataraxis" },
    ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "  Truzen minimal" },
    ["<leader>tf"] = { "<cmd> TZFocus <CR>", "  Truzen focus" },
  },

  v = {
    ["<leader>tn"] = { ":'<,'>TZNarrow <CR>", "  Truzen narrow" },
  },
}

M.dashboard = {
  n = {
    ["<leader>db"] = { "<cmd> Nvdash <CR>", "舘  Show dashboard" },
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
    -- Pasting
    ["<C-p>"] = { "<cmd> pu <CR>", "  Paste in line under" },

    -- Moving lines/words
    ["<A-k>"] = { "<cmd> MoveLine(-1) <CR>", "  Move curent line up" },
    ["<A-j>"] = { "<cmd> MoveLine(1) <CR>", "  Move curent line down" },
    ["<A-l>"] = { "<cmd> MoveWord(1) <CR>", "  Move curent word left" },
    ["<A-h>"] = { "<cmd> MoveWord(-1) <CR>", "  Move curent word right" },

    -- Duplicating lines
    ["<A-S-k>"] = { "<cmd> t- <CR>", "  Duplicate curent line up" },
    ["<A-S-j>"] = { "<cmd> t.  <CR>", "  Duplicate curent line down" },

    -- Saving files
    ["<C-S-s>"] = {
      "<cmd> set eventignore+=BufWritePre | w | set eventignore-=BufWritePre <CR>",
      "󱪚  Save file without formatting",
    },
  },
  v = {
    -- Moving selection
    ["<A-k>"] = { ":MoveBlock(-1) <CR>", "  Move selected block up" },
    ["<A-j>"] = { ":MoveBlock(1) <CR>", "  Move selected block down" },
    ["<A-l>"] = { ":MoveHBlock(1) <CR>", "  Move selected block up" },
    ["<A-h>"] = { ":MoveHBlock(-1) <CR>", "  Move selected block down" },

    -- Duplicating lines
    ["<A-S-k>"] = { ":copy- <CR>", "  Duplicate curent line up" },
    -- ["<A-S-j>"] = { ":copy.  <CR>", "  Duplicate curent line down" },
  },
}

M.marks = {
  n = {
    ["m"] = {
      function()
        require("marks").toggle_mark()
      end,
      "Toggle mark",
    },
    ["m;"] = {
      function()
        require("marks").toggle()
      end,
      "Toggle next available mark",
    },
    ["m:"] = {
      function()
        require("marks").preview()
      end,
      "Preview mark",
    },
    ["dm"] = {
      function()
        require("marks").delete()
      end,
      "Delete mark",
    },
    ["dm-"] = {
      function()
        require("marks").delete_line()
      end,
      "Delete all marks on current line",
    },
    ["dm<space>"] = {
      function()
        require("marks").delete_buf()
      end,
      "Delete all marks in current buffer",
    },
    ["m]"] = {
      function()
        require("marks").next()
      end,
      "Go to the next mark",
    },
    ["m["] = {
      function()
        require("marks").prev()
      end,
      "Go to the previous mark",
    },
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
