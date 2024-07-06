local configs = require "nvchad.configs.lspconfig"

local map = vim.keymap.set

local on_attach = function(client, bufnr)
  configs.on_attach(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end

  map("n", "gr", "<cmd> Telescope lsp_references <CR>", opts " Lsp Show references")
end

local on_init = configs.on_init
local capabilities = configs.capabilities

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
}

local no_formatting = {
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
