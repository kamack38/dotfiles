local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "html",
    "css",
    "rust",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "yaml",
    "toml",
    "markdown",
    "latex",
    "c",
    "nix",
    "cpp",
    "bash",
    "fish",
    "lua",
    "rasi",
    "norg",
    "python",
  },
}

M.nvimtree = {
  git = {
    enable = true,
    ignore = false,
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
