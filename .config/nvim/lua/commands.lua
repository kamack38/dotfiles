local create_cmd = vim.api.nvim_create_user_command
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Add alias for quit
create_cmd("Q", "quit", {})

-- Add alias for vertical resize
create_cmd("Vres", function(opts)
  vim.cmd("vertical resize " .. opts.args)
end, { nargs = 1 })

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

-- Cargo.toml keybindigs
augroup("Cargo.toml", { clear = true })
autocmd("BufRead", {
  group = "Cargo.toml",
  pattern = "*Cargo.toml",
  callback = function(opts)
    local crates = require "crates"
    local map = vim.keymap.set
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
    local map = vim.keymap.set
    map("n", "<leader>nu", package.update, { buffer = opts.buf, desc = "Package.json Update selected package" })
    map("n", "<leader>nd", package.delete, { buffer = opts.buf, desc = "Package.json Delete selected package" })
    map("n", "<leader>ni", package.install, { buffer = opts.buf, desc = "Package.json Install new package" })
    map("n", "<leader>np", package.change_version, { buffer = opts.buf, desc = "Package.json Change package version" })
  end,
})
