local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

capabilities.offsetEncoding = { "utf-16" }

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "rust_analyzer",
  "emmet_ls",
  "tsserver",
  "tailwindcss",
  "texlab",
}

local no_formatting = {
  "jsonls",
  "clangd",
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
      on_attach()
    end,
  }
end
