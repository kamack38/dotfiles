local configs = require "nvchad.configs.lspconfig"

local on_init = configs.on_init
local capabilities = configs.capabilities
local on_attach = configs.on_attach

local lspconfig = require "lspconfig"
local servers = {
  "clangd",
  "cssls",
  -- "emmet_ls",
  "html",
  "nil_ls",
  "ruff",
  -- "tailwindcss",
  "texlab",
  "ts_ls",
  "typos_lsp",
}

lspconfig.rust_analyzer.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  settings = {
    ["rust_analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
}

lspconfig.biome.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = true,
}

lspconfig.tinymist.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = true,
  settings = {
    exportPdf = "onType",
    outputPath = "$root/target/$dir/$name",
  },
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
