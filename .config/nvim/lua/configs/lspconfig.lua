local configs = require "nvchad.configs.lspconfig"

local on_init = configs.on_init
local capabilities = configs.capabilities
local on_attach = configs.on_attach

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  -- "emmet_ls",
  "tsserver",
  -- "tailwindcss",
  "texlab",
  "ruff_lsp",
  "typst_lsp",
  "nil_ls",
  "typos_lsp",
}

local no_formatting = {
  "clangd",
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

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

for _, lsp in ipairs(no_formatting) do
  lspconfig[lsp].setup {
    on_init = on_init,
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      client.server_capabilities.offsetEncoding = "utf-16"
      on_attach(client, bufnr)
    end,
  }
end
