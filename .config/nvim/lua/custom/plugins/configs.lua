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


return M
