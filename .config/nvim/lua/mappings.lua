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

-- Telescope
map("n", "<leader>wk", "<cmd> Telescope keymaps <CR>", { desc = "Telescope find keys" })
map("n", "<leader>fn", "<cmd> Nerdy <CR>", { desc = "Find NerdFonts" })

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

-- Moving selection
map("v", "<A-k>", ":MoveBlock(-1) <CR>", { desc = "Move selected block up" })
map("v", "<A-j>", ":MoveBlock(1) <CR>", { desc = "Move selected block down" })

-- Duplicating lines
map({ "n", "v" }, "<A-S-k>", ":copy- <CR>", { desc = "Duplicate current line up" })
map({ "n", "v" }, "<A-S-j>", ":copy.  <CR>", { desc = "Duplicate current line down" })

-- Duplicating lines
-- map("v", "<A-S-k>", "<cmd> copy- <CR>", { desc = "Duplicate current line up" })
-- map("v", "<A-S-j>", ":copy.  <CR>", { desc = "Duplicate current line down" })

-- Changing windows
map({ "n" }, "<A-w>", "<C-w>")

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
    return
  end

  -- retrieve URL with the z-register as intermediary
  vim.cmd.normal { '"zy', bang = true }
  local url = vim.fn.getreg "z"
  vim.ui.open(url)
end, { desc = "Open next available link" })

-- Terminal
map({ "n" }, "<leader>tt", "<cmd>term<CR>")

-- LspUI
map("n", "<leader>cn", "<cmd> LspUI rename <CR>", { desc = "LSP rename (change name)" })
map("n", "<C-space>", "<cmd> LspUI code_action <CR>", { desc = "LSP show code action menu" })
-- map("n", "K", "<cmd> LspUI hover <CR>", { desc = "  LSP hover" })

-- Leap
map("n", "<leader>s", function()
  require("leap").leap { target_windows = { vim.fn.win_getid() } }
end, { desc = "Jump to search" })
map("n", "<leader>S", function()
  require("leap").leap { offset = -1, target_windows = { vim.fn.win_getid() } }
end, { desc = "Jump till search" })
