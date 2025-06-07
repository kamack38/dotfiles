local options = {
  lsp_fallback = true,

  formatters = {
    shfmt = {
      prepend_args = { "-i", "0" },
    },
    biome = {
      append_args = { "--indent-style=space" },
    },
    ["deno_fmt"] = {
      append_args = { "--line-width", "100" },
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
    toml = { "taplo" },
    markdown = { "deno_fmt" },
    typst = { "typstyle" },
    sql = { "sqruff" },

    rust = { "rustfmt" },
    nix = { "nixfmt" },
    lua = { "stylua" },

    sh = { "shfmt" },
    fish = { "fish_indent" },

    kotlin = { "ktlint" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

require("conform").setup(options)
