local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

capabilities.offsetEncoding = { "utf-16" }

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "bashls", "clangd", "emmet_ls", "tsserver" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
