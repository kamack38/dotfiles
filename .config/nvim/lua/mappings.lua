require "nvchad.mappings"

local map = vim.keymap.set

-- ZenMode
map("n", "<leader>tz", "<cmd> ZenMode <CR>", { desc = "  Toggle zen mode" })

-- Dashboard
map("n", "<leader>db", "<cmd> Nvdash <CR>", { desc = "舘  Show dashboard" })

-- Telescope
map("n", "<leader>wk", "<cmd> Telescope keymaps <CR>", { desc = "  Find keys" })

-- CodeRunner
map("n", "<F7>", "<cmd> RunFile <CR>", { desc = "  Run code" })

-- Trouble
map("n", "<C-S-m>", "<cmd> TroubleToggle <CR>", { desc = "  Show diagnostics" })

-- Pasting
map("n", "<C-p>", "<cmd> pu <CR>", { desc = "  Paste in line under" })

-- Moving lines/words
map("n", "<A-k>", "<cmd> MoveLine(-1) <CR>", { desc = "  Move current line up" })
map("n", "<A-j>", "<cmd> MoveLine(1) <CR>", { desc = "  Move current line down" })
map("n", "<A-h>", "<cmd> MoveWord(-1) <CR>", { desc = "  Move current word right" })
map("n", "<A-l>", "<cmd> MoveWord(1) <CR>", { desc = "  Move current word left" })

-- Duplicating lines
map("n", "<A-S-k>", "<cmd> t- <CR>", { desc = "  Duplicate current line up" })
map("n", "<A-S-j>", "<cmd> t.  <CR>", { desc = "  Duplicate current line down" })

-- Saving files
map(
  "n",
  "<C-S-s>",
  "<cmd> set eventignore+=BufWritePre | w | set eventignore-=BufWritePre <CR>",
  { desc = "󱪚  Save file without formatting" }
)
-- Moving selection
map("v", "<A-k>", ":MoveBlock(-1) <CR>", { desc = "  Move selected block up" })
map("v", "<A-j>", ":MoveBlock(1) <CR>", { desc = "  Move selected block down" })
map("v", "<A-l>", ":MoveHBlock(1) <CR>", { desc = "  Move selected block up" })
map("v", "<A-h>", ":MoveHBlock(-1) <CR>", { desc = "  Move selected block down" })

-- Duplicating lines
map("v", "<A-S-k>", ":copy- <CR>", { desc = "  Duplicate current line up" })
-- map("v", "<A-S-j>", ":copy.  <CR>", { desc = "  Duplicate current line down" })
map("i", "<A-;>", "<ESC>", { noremap = true, silent = true })

-- Spider
map({ "n", "v" }, "w", function()
  require("spider").motion "w"
end, { desc = "spider-w" })
map({ "n", "v" }, "e", function()
  require("spider").motion "e"
end, { desc = "spider-e" })
map({ "n", "v" }, "b", function()
  require("spider").motion "b"
end, { desc = "spider-b" })
map({ "n", "v" }, "ge", function()
  require("spider").motion "ge"
end, { desc = "spider-ge" })

-- M.dap = {
-- 	n = {
-- 		["<F5>"] = {
-- 			function()
-- 				require("dap").continue()
-- 			end,
-- 			"Continue to another breakpoint",
-- 		},
-- 		["<F10>"] = {
-- 			function()
-- 				require("dap").step_over()
-- 			end,
-- 			"Step over",
-- 		},
-- 		["<F11>"] = {
-- 			function()
-- 				require("dap").step_into()
-- 			end,
-- 			"Step into",
-- 		},
-- 		["<F12>"] = {
-- 			function()
-- 				require("dap").step_out()
-- 			end,
-- 			"Step out",
-- 		},
-- 		["<leader>tb"] = {
-- 			function()
-- 				require("dap").toggle_breakpoint()
-- 			end,
-- 			"Toggle breakpoint",
-- 		},
-- 	},
-- }

-- LspUI
map("n", "<leader>cn", "<cmd> LspUI rename <CR>", { desc = "  LSP rename (change name)" })
map("n", "<C-space>", "<cmd> LspUI code_action <CR>", { desc = "  Show code action menu" })

-- Marks
map("n", "m", function()
  require("marks").toggle_mark()
end, { desc = "Toggle mark" })
map("n", "m;", function()
  require("marks").toggle()
end, { desc = "Toggle next available mark" })
map("n", "m:", function()
  require("marks").preview()
end, { desc = "Preview mark" })
map("n", "dm", function()
  require("marks").delete()
end, { desc = "Delete mark" })
map("n", "dm-", function()
  require("marks").delete_line()
end, { desc = "Delete all marks on current line" })
map("n", "dm<space>", function()
  require("marks").delete_buf()
end, { desc = "Delete all marks in current buffer" })
map("n", "m]", function()
  require("marks").next()
end, { desc = "Go to the next mark" })
map("n", "m[", function()
  require("marks").prev()
end, { desc = "Go to the previous mark" })

-- Leap
map("n", "<leader>s", function()
  require("leap").leap { target_windows = { vim.fn.win_getid() } }
end, { desc = "  Jump to search" })
map("n", "<leader>S", function()
  require("leap").leap { offset = -1, target_windows = { vim.fn.win_getid() } }
end, { desc = "  Jump till search" })
