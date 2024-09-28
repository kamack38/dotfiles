local options = {
  lsp_fallback = true,

  formatters = {
    clang_format = {
      args = { "--style", "{ BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 100 }" },
    },
    shfmt = {
      inherit = false,
      command = "shfmt",
      args = { "-i", "0", "-filename", "$FILENAME" },
    },
  },

  formatters_by_ft = {
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },

    css = { "biome" },
    html = { "biome" },
    json = { "biome" },
    jsonc = { "biome" },
    markdown = { "deno_fmt" },

    cpp = { "clang_format" },
    rust = { "rustfmt" },
    nix = { "nixfmt" },
    lua = { "stylua" },

    sh = { "shfmt" },
    fish = { "fish_indent" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

require("conform").setup(options)
