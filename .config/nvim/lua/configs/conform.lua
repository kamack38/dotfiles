local config_home = (os.getenv("XDG_CONFIG_HOME"))
    or (os.getenv("HOME") and os.getenv("HOME") .. "/.config")
    or (os.getenv("HOMEPATH") and os.getenv("HOMEPATH") .. "/.config")
    or ""

local options = {
  formatters = {
    shfmt = {
      prepend_args = { "-i", "0" },
    },
    biome = {
      append_args = { "--config-path", config_home .. "/biome.json" }
    },
    ["deno_fmt"] = {
      append_args = { "--line-width", "100" },
    },
  },

  formatters_by_ft = {
    asm = { "asmfmt" },
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
    lsp_format = "prefer",
  },
}

require("conform").setup(options)
