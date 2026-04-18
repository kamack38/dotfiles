require "nvchad.mappings"

local map = vim.keymap.set
local utils = require "utils"

-- Lazy
map("n", "<leader>uu", "<cmd> Lazy sync <CR>", { desc = "Lazy sync" })

-- ZenMode
map("n", "<leader>tz", "<cmd> ZenMode <CR>", { desc = "ZenMode toggle" })

-- Dashboard
map("n", "<leader>db", "<cmd> Nvdash <CR>", { desc = "Show dashboard" })

-- Menu
map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

-- FzfLua
map("n", "<leader>wk", "<cmd> FzfLua keymaps <CR>", { desc = "FzfLua find keys" })
-- map("n", "<leader>fn", "<cmd> Nerdy <CR>", { desc = "Find NerdFonts" })
map("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "FzfLua find files" })
map("n", "<leader>fa", "<cmd>FzfLua files hidden=true <CR>", { desc = "FzfLua find all files" })
map("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "FzfLua live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "FzfLua find buffers" })
map("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "FzfLua help page" })
map("n", "<leader>ma", "<cmd>FzfLua marks<CR>", { desc = "FzfLua find marks" })
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "FzfLua find oldfiles" })
map("n", "<leader>fz", "<cmd>FzfLua current_buffer_fuzzy_find<CR>", { desc = "FzfLua find in current buffer" })
map("n", "<leader>cm", "<cmd>FzfLua git_commits<CR>", { desc = "FzfLua git commits" })
map("n", "<leader>gt", "<cmd>FzfLua git_status<CR>", { desc = "FzfLua git status" })
map("n", "<leader>fl", "<cmd>FzfLua highlights<CR>", { desc = "FzfLua highlights" })

-- CodeRunner
map("n", "<F7>", "<cmd> RunFile <CR>", { desc = "Run code" })

-- Trouble
map("n", "<C-S-m>", "<cmd> Trouble diagnostics toggle<CR>", { desc = "LSP show diagnostics" })

-- Todo-comments
map("n", "<leader>td", "<cmd> Trouble todo toggle <CR>", { desc = "Todo-comments show" })
map("n", "]t", require("todo-comments").jump_next, { desc = "Todo-comments next" })
map("n", "[t", require("todo-comments").jump_prev, { desc = "Todo-comments previous" })

-- Pasting
map("n", "<C-p>", "<cmd> pu <CR>", { desc = "Paste in line under" })

-- Moving lines/words
map("n", "<A-k>", "<cmd> MoveLine(-1) <CR>", { desc = "Move current line up" })
map("n", "<A-j>", "<cmd> MoveLine(1) <CR>", { desc = "Move current line down" })
map("v", "<A-k>", ":MoveBlock(-1) <CR>", { desc = "Move selected block up" })
map("v", "<A-j>", ":MoveBlock(1) <CR>", { desc = "Move selected block down" })

-- Duplicating lines
map("n", "<A-S-k>", ":copy- <CR>", { desc = "Duplicate current line up" })
map("n", "<A-S-j>", ":copy. <CR>", { desc = "Duplicate current line down" })
map("v", "<A-S-k>", ":copy- <CR>", { desc = "Duplicate selected lines up" })
map("v", "<A-S-j>", ":copy'> <CR>", { desc = "Duplicate selected lines down" })

-- Changing windows
map({ "n" }, "<A-w>", "<C-w>")

-- Toggle split height between its default and its max
map({ "n", "t" }, "<A-e>", utils.expand_height, { noremap = true, silent = true })

-- Toggle split width between its default and its max
map({ "n", "t" }, "<A-y>", utils.expand_width, { noremap = true, silent = true })

-- Saving files
map(
  "n",
  "<C-S-s>",
  "<cmd> set eventignore+=BufWritePre | w | set eventignore-=BufWritePre <CR>",
  { desc = "File save without formatting" }
)

-- Escaping modes
map("i", "<A-;>", "<ESC>", { noremap = true, silent = true })
map("t", "<A-;>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- History in command mode
map("c", "<C-k>", "<Up>")
map("c", "<C-j>", "<Down>")

-- Cursor to beginning in command mode
map("c", "<C-a>", "<C-b>")

-- Reselect pasted text
map("n", "gp", "`[v`]", { desc = "reselect pasted text" })

-- Spider
map({ "n", "v" }, "w", function()
  require("spider").motion "w"
end, { desc = "Spider w" })
map({ "n", "v" }, "e", function()
  require("spider").motion "e"
end, { desc = "Spider e" })
map({ "n", "v" }, "b", function()
  require("spider").motion "b"
end, { desc = "Spider b" })
map({ "n", "v" }, "ge", function()
  require("spider").motion "ge"
end, { desc = "Spider ge" })

-- Textobjects
map({ "o", "x" }, "ac", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
map({ "o", "x" }, "ic", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
map("n", "gx", utils.open_next_link, { desc = "Open next available link" })

-- TS Textobjects
local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
local ts_move = require("nvim-treesitter-textobjects.move")
local ts_keymaps = {
  ["aa"] = "@parameter.outer",
  ["ia"] = "@parameter.inner",
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["as"] = "@local.sope",
}
for mapping, query in pairs(ts_keymaps) do
  map({ "x", "o" }, mapping, function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
  end, { desc = "Select " .. query })
end
map({ "n", "x", "o" }, "]m", function()
  ts_move.goto_next_start("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "]M", function()
  ts_move.goto_next_end("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "[m", function()
  ts_move.goto_previous_start("@function.outer", "textobjects")
end)
map({ "n", "x", "o" }, "[M", function()
  ts_move.goto_previous_end("@function.outer", "textobjects")
end)

-- Repeat movement with ; and ,
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Make builtin f, F, t, T also repeatable with ; and ,
map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

-- Terminal
map({ "n" }, "<leader>tt", ":terminal<CR>i")

-- Lsp
map("n", "<leader>cn", require "nvchad.lsp.renamer", { desc = "LSP Rename" })
map({ "n", "x" }, "<leader>ca", require("tiny-code-action").code_action,
  { noremap = true, silent = true, desc = "LSP Code actions" })
map("n", "gl", vim.diagnostic.open_float, { desc = "LSP Show diagnostics" })
map("n", "gy", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "LSP Toggle inlay hints" })
map("n", "K", utils.hover_handler, { desc = "LSP Hover" })

-- Dap
map("n", "<leader>b", "<cmd>DapToggleBreakpoint<cr>", { desc = "Debug: Toggle Breakpoint" })

-- Leap
map("n", "<leader>s", function()
  require("leap").leap { target_windows = { vim.fn.win_getid() } }
end, { desc = "Jump to search" })
map("n", "<leader>S", function()
  require("leap").leap { offset = -1, target_windows = { vim.fn.win_getid() } }
end, { desc = "Jump till search" })

-- Marks
map("n", "m", utils.toggle_mark, { desc = "Toggle mark under cursor" })
map("n", "dm", utils.delete_mark, { desc = "Delete mark", noremap = true })
map("n", "dm;", utils.delete_marks_on_line, { desc = "Delete marks on the current line" })
map("n", "dm<Space>", utils.delete_all_marks, { desc = "Delete all marks in the current buffer" })
map("n", "m]", utils.jump_next_mark, { desc = "Jump to next lowercase mark" })
map("n", "m[", utils.jump_prev_mark, { desc = "Jump to previous lowercase mark" })
