local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {

  -- spelling
  -- b.diagnostics.cspell.with {
  --    diagnostics_postprocess = function(diagnostic)
  --       diagnostic.severity = vim.diagnostic.severity["INFO"]
  --    end,
  --    extra_args = { "--locale en-GB,pl" },
  -- },

  -- webdev stuff
  b.formatting.prettierd.with { filetypes = { "html", "markdown", "css", "json", "yaml", "scss" } },

  -- Lua
  b.formatting.stylua, --.with { extra_args = { "--indent-type Spaces" } },
  b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
  b.diagnostics.fish,

  -- cpp
  b.formatting.clang_format.with {
    extra_args = { "--style", "{ BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 500 }" },
  },
}

local M = {}

M.setup = function()
  null_ls.setup {
    debug = true,
    sources = sources,
    -- format on save
    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
      end
    end,
  }
end

return M
