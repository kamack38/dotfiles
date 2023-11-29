local create_cmd = vim.api.nvim_create_user_command
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Add alias for quit
create_cmd("Q", "quit", {})

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
    local wk = require "which-key"
    wk.register({
      ["<leader>c"] = {
        name = "Crates",
        ["t"] = { crates.toggle, "Toggle" },
        ["r"] = { crates.reload, "Reload" },

        ["v"] = { crates.show_versions_popup, "Versions popup" },
        ["f"] = { crates.show_features_popup, "Features popup" },
        ["d"] = { crates.show_dependencies_popup, "Dependencies popup" },

        ["u"] = { crates.update_crate, "Update crate" },
        ["U"] = { crates.upgrade_crate, "Upgrade crate" },
        ["a"] = { crates.update_all_crates, "Update all crates" },
        ["A"] = { crates.upgrade_all_crates, "Upgrade all crates" },

        ["H"] = { crates.open_homepage, "Open homepage" },
        ["R"] = { crates.open_repository, "Open repository" },
        ["D"] = { crates.open_documentation, "Open documentation" },
        ["C"] = { crates.open_crates_io, "Open crates.io" },
      },
    }, { buffer = opts.buf })
  end,
})

-- package.json keybindigs
augroup("package.json", { clear = true })
autocmd("BufRead", {
  group = "package.json",
  pattern = "*package.json",
  callback = function(opts)
    local package = require "package-info"
    local wk = require "which-key"
    wk.register({
      ["<leader>n"] = {
        name = "Package info",
        ["u"] = { package.update, "Update selected package" },
        ["d"] = { package.delete, "Delete selected package" },
        ["i"] = { package.install, "Install new package" },
        ["p"] = { package.change_version, "Change package version" },
      },
    }, { buffer = opts.buf })
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "PKGBUILD",
  callback = function(opts)
    vim.bo[opts.buf].filetype = "PKGBUILD"
  end,
})
