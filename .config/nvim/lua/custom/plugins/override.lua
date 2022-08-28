local M = {}

M.treesitter = {
    ensure_installed = {
        "vim",
        "html",
        "css",
        "javascript",
        "typescript",
        "json",
        "yaml",
        "toml",
        "markdown",
        "c",
        "cpp",
        "bash",
        "fish",
    },
}

M.nvimtree = {
    git = {
        enable = true,
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
  },
}

return M
