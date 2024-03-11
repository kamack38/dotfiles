local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "emmet_ls",
  "tsserver",
  "tailwindcss",
  "texlab",
  "pkgbuild_language_server",
  "ruff_lsp",
}

local no_formatting = {
  "jsonls",
  "clangd",
}

lspconfig.rust_analyzer.setup {
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

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

for _, lsp in ipairs(no_formatting) do
  lspconfig[lsp].setup {
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      client.server_capabilities.offsetEncoding = "utf-16"
      on_attach()
    end,
  }
end
