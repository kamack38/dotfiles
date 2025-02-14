local configs = require "nvchad.configs.lspconfig"

local servers = {
  clangd = {},
  cssls = {},
  -- emmet_ls = {},
  html = {},
  nil_ls = {},
  ruff = {},
  -- tailwindcss = {},
  texlab = {},
  ts_ls = {},
  typos_lsp = {},
  rust_analyzer = {
    filetypes = { "rust" },
    settings = {
      ["rust_analyzer"] = {
        cargo = {
          allFeatures = true,
        },
      },
    },
  },
  biome = {
    single_file_support = true,
  },
  tinymist = {
    single_file_support = true,
    settings = {
      exportPdf = "onType",
      outputPath = "$root/target/$dir/$name",
    },
  }
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end
