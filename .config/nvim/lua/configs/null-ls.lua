local null_ls = require "null-ls"

local actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {

  -- spelling
  lint.cspell.with {
    diagnostics_postprocess = function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity["INFO"]
    end,
    -- extra_args = { "--locale", "en-GB,pl" },
  },
  actions.cspell,

  -- WebDev
  actions.eslint,

  -- Shell
  lint.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
  lint.fish,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup {
  debug = true,
  sources = sources,
  -- format on save
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}
