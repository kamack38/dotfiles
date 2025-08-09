require "nvchad.mappings"

local map = vim.keymap.set

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
map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Todo-comments next" })
map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Todo-comments previous" })

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
map({ "n", "t" }, "<A-e>", function()
  local win_id = vim.api.nvim_get_current_win()
  local current_height = vim.api.nvim_win_get_height(win_id)

  if vim.b.max_height == nil then
    vim.b.max_height = 100
  end

  if current_height ~= vim.b.max_height then
    vim.b.default_height = current_height
    vim.api.nvim_win_set_height(win_id, vim.b.max_height)
    vim.b.max_height = vim.api.nvim_win_get_height(win_id)
  else
    vim.api.nvim_win_set_height(win_id, vim.b.default_height)
  end
end, { noremap = true, silent = true })

-- Toggle split width between its default and its max
map({ "n", "t" }, "<A-y>", function()
  local win_id = vim.api.nvim_get_current_win()
  local current_width = vim.api.nvim_win_get_width(win_id)

  if vim.b.max_width == nil then
    vim.b.max_width = 999
  end

  if current_width ~= vim.b.max_width then
    vim.b.default_width = current_width
    vim.api.nvim_win_set_width(win_id, vim.b.max_width)
    vim.b.max_width = vim.api.nvim_win_get_width(win_id)
  else
    vim.api.nvim_win_set_width(win_id, vim.b.default_width)
  end
end, { noremap = true, silent = true })

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
map("n", "gx", function()
  -- select URL
  require("various-textobjs").url()

  -- plugin only switches to visual mode when textobj is found
  local foundURL = vim.fn.mode():find "v"
  if not foundURL then
    vim.cmd("tag " .. vim.fn.expand("<cword>"))
    return
  end

  local url = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = "v" })[1]
  vim.ui.open(url)
  vim.cmd.normal { "v", bang = true } -- leave visual mode
end, { desc = "Open next available link" })

-- Terminal
map({ "n" }, "<leader>tt", ":terminal<CR>i")

-- Lsp
map("n", "<leader>cn", require "nvchad.lsp.renamer", { desc = "LSP Rename" })
map({ "n", "x" }, "<leader>ca", function()
  require("tiny-code-action").code_action()
end, { noremap = true, silent = true, desc = "LSP Code actions" })
map("n", "gl", vim.diagnostic.open_float, { desc = "LSP Show diagnostics" })
map("n", "K", function()
  vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "LSP Hover" })

-- Leap
map("n", "<leader>s", function()
  require("leap").leap { target_windows = { vim.fn.win_getid() } }
end, { desc = "Jump to search" })
map("n", "<leader>S", function()
  require("leap").leap { offset = -1, target_windows = { vim.fn.win_getid() } }
end, { desc = "Jump till search" })
