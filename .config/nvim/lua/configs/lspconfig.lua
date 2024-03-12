local configs = require "nvchad.configs.lspconfig"

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

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

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "󰅙")
lspSymbol("Info", "󰋼")
lspSymbol("Hint", "󰌵")
lspSymbol("Warn", "")

vim.diagnostic.config {
  virtual_text = {
    prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
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
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      client.server_capabilities.offsetEncoding = "utf-16"
      on_attach()
    end,
  }
end
