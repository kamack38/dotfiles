local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "html",
    "css",
    "rust",
    "javascript",
    "typescript",
    "json",
    "yaml",
    "toml",
    "markdown",
    "latex",
    "c",
    "cpp",
    "bash",
    "fish",
    "lua",
    "rasi",
    "norg",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
}

M.mason = {
  ensure_installed = {
    -- web dev
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "emmet-ls",
    "json-lsp",

    -- shell
    "shfmt",
    "shellcheck",

    -- cpp
    "clangd",

    -- lua
    "stylua",
  },
}

return M
