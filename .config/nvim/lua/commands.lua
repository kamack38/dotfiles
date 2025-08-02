local create_cmd = vim.api.nvim_create_user_command
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
local map = vim.keymap.set

-- Add alias for quit
create_cmd("Q", "quit", {})
create_cmd("ReloadHighlights", function()
  require("base46").load_all_highlights()
end, {})

-- Add alias for vertical resize
create_cmd("Vres", function(opts)
  vim.cmd("vertical resize " .. opts.args)
end, { nargs = 1 })

-- Add an alias for Markview plugin
create_cmd("MV", "Markview", {})

-- Cd To Buffer Root
create_cmd("CdBufferRoot", function()
  local dir = vim.fn.expand "%:h"
  vim.cmd("cd " .. dir)
end, {})

-- Editor config reload
create_cmd("EditorConfigReload", function()
  vim.api.nvim_exec_autocmds("BufReadPost", { buffer = 0 })
end, {})

-- Hide line numbers inside terminals
autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})

-- Dynamic terminal padding
autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.cmd "silent !kitty @ set-spacing padding=0"
  end,
})
autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    vim.cmd "silent !kitty @ set-spacing padding=default"
  end,
})

-- Tex preview
function GeneratePDF(file)
  local dir = string.match(file, "(.*)/")
  vim.fn.jobstart { "mkdir", "-p", dir .. "/bin" }
  vim.fn.jobstart { "pdflatex", "-halt-on-error", "-output-directory", dir .. "/bin", file }
end

create_cmd("TexPreview", function()
  local current_file = vim.api.nvim_buf_get_name(0)
  local parent_dir = string.match(current_file, "(.*)/")
  GeneratePDF(current_file)
  vim.fn.jobstart { "xdg-open", parent_dir .. "/bin/" .. string.match(current_file, ".*/(.*).tex") .. ".pdf" }
  augroup("TexLivePreview", { clear = true })
  autocmd("BufWritePost", {
    group = "TexLivePreview",
    pattern = "*.tex",
    callback = function(opts)
      GeneratePDF(opts.match)
    end,
  })
end, {})

-- Show Nvdash when no buffers are opened
autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

-- Restore cursor position on file open
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
        line > 1
        and line <= vim.fn.line "$"
        and vim.bo.filetype ~= "commit"
        and vim.bo.filetype ~= "gitcommit"
        and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

local user_cmds = augroup("user.cmds", { clear = true })

local function update_git_env_for_dotfiles()
  -- Auto change ENV variables to enable
  -- bare git repository for dotfiles after
  -- loading saved session
  local home = vim.fn.expand "~"
  local git_dir = home .. "/.dotfiles"

  if vim.env.GIT_DIR ~= nil and vim.env.GIT_DIR ~= git_dir then
    return
  end

  -- check dotfiles dir exists on current machine
  if vim.fn.isdirectory(git_dir) ~= 1 then
    vim.env.GIT_DIR = nil
    vim.env.GIT_WORK_TREE = nil
    return
  end

  -- check if the current working directory should belong to dotfiles
  local cwd = vim.loop.cwd()
  if vim.startswith(cwd, home .. "/.config/") or cwd == home or cwd == home .. "/.local/bin" then
    if vim.env.GIT_DIR == nil then
      -- export git location into ENV
      vim.env.GIT_DIR = git_dir
      vim.env.GIT_WORK_TREE = home
    end
  else
    if vim.env.GIT_DIR == git_dir then
      -- unset variables
      vim.env.GIT_DIR = nil
      vim.env.GIT_WORK_TREE = nil
    end
  end
end

autocmd("DirChanged", {
  pattern = { "*" },
  group = user_cmds,
  desc = "Update git env for dotfiles after changing directory",
  callback = function()
    update_git_env_for_dotfiles()
  end,
})

autocmd("User", {
  pattern = { "SessionLoadPost" },
  group = user_cmds,
  desc = "Update git env for dotfiles after loading session",
  callback = function()
    update_git_env_for_dotfiles()
  end,
})

-- Cargo.toml keybindigs
augroup("Cargo.toml", {})
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

-- fix fzf lua
autocmd("FileType", {
  pattern = "fzf",
  callback = function(opts)
    map("t", "<A-;>", "<A-;>", { buffer = opts.buf })
  end,
})
