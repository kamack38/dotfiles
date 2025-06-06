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
    vim.api.nvim_win_set_height(win_id, 100)
    vim.b.max_height = vim.api.nvim_win_get_height(win_id)
  else
    vim.api.nvim_win_set_height(win_id, vim.b.default_height)
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
    return
  end

  -- retrieve URL with the z-register as intermediary
  vim.cmd.normal { '"zy', bang = true }
  local url = vim.fn.getreg "z"
  vim.ui.open(url)
end, { desc = "Open next available link" })

-- Terminal
map({ "n" }, "<leader>tt", ":terminal<CR>i")

-- LspUI
map("n", "<leader>cn", "<cmd> LspUI rename <CR>", { desc = "LSP rename (change name)" })
map("n", "<C-space>", "<cmd> LspUI code_action <CR>", { desc = "LSP show code action menu" })
-- map("n", "K", "<cmd> LspUI hover <CR>", { desc = "  LSP hover" })
map("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics" })

-- Leap
map("n", "<leader>s", function()
  require("leap").leap { target_windows = { vim.fn.win_getid() } }
end, { desc = "Jump to search" })
map("n", "<leader>S", function()
  require("leap").leap { offset = -1, target_windows = { vim.fn.win_getid() } }
end, { desc = "Jump till search" })

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Cargo.toml keybindigs
augroup("Cargo.toml", { clear = true })
autocmd("BufRead", {
  group = "Cargo.toml",
  pattern = "*Cargo.toml",
  callback = function(opts)
    local crates = require "crates"
    map("n", "<leader>ct", crates.toggle, { buffer = opts.buf, desc = "Crates Toggle" })
    map("n", "<leader>cr", crates.reload, { buffer = opts.buf, desc = "Crates Reload" })
    map("n", "<leader>cv", crates.show_versions_popup, { buffer = opts.buf, desc = "Crates Versions popup" })
    map("n", "<leader>cf", crates.show_features_popup, { buffer = opts.buf, desc = "Crates Features popup" })
    map("n", "<leader>cd", crates.show_dependencies_popup, { buffer = opts.buf, desc = "Crates Dependencies popup" })
    map("n", "<leader>cu", crates.update_crate, { buffer = opts.buf, desc = "Crates Update crate" })
    map("n", "<leader>cU", crates.upgrade_crate, { buffer = opts.buf, desc = "Crates Upgrade crate" })
    map("n", "<leader>ca", crates.update_all_crates, { buffer = opts.buf, desc = "Crates Update all crates" })
    map("n", "<leader>cA", crates.upgrade_all_crates, { buffer = opts.buf, desc = "Crates Upgrade all crates" })
    map("n", "<leader>cH", crates.open_homepage, { buffer = opts.buf, desc = "Crates Open homepage" })
    map("n", "<leader>cR", crates.open_repository, { buffer = opts.buf, desc = "Crates Open repository" })
    map("n", "<leader>cD", crates.open_documentation, { buffer = opts.buf, desc = "Crates Open documentation" })
    map("n", "<leader>cC", crates.open_crates_io, { buffer = opts.buf, desc = "Crates Open crates.io" })
  end,
})

-- package.json keybindigs
augroup("package.json", { clear = true })
autocmd("BufRead", {
  group = "package.json",
  pattern = "*package.json",
  callback = function(opts)
    local package = require "package-info"
    map("n", "<leader>nu", package.update, { buffer = opts.buf, desc = "Package.json Update selected package" })
    map("n", "<leader>nd", package.delete, { buffer = opts.buf, desc = "Package.json Delete selected package" })
    map("n", "<leader>ni", package.install, { buffer = opts.buf, desc = "Package.json Install new package" })
    map("n", "<leader>np", package.change_version, { buffer = opts.buf, desc = "Package.json Change package version" })
  end,
})
