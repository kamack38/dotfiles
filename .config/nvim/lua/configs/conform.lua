local options = {
  lsp_fallback = true,

  formatters = {
    clang_format = {
      args = { "--style", "{ BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 100 }" },
    },
    shfmt = {},
    -- prettierd = {},
  },

  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    nix = { "nixfmt" },

    -- webdev
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },

    css = { "biome" },
    html = { "biome" },
    json = { "biome" },
    jsonc = { "biome" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
