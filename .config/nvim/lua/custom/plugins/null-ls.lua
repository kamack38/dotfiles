local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- spelling
  -- b.diagnostics.cspell.with {
  --   diagnostics_postprocess = function(diagnostic)
  --     diagnostic.severity = vim.diagnostic.severity["INFO"]
  --   end,
  --   extra_args = { "--locale", "en-GB,pl" },
  -- },
  -- b.code_actions.cspell,

  -- webdev stuff
  b.code_actions.eslint,
  b.formatting.prettierd.with {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "css",
      "scss",
      "html",
      "json",
      "jsonc",
      "yaml",
      "markdown",
      "markdown.mdx",
    },
  },

  -- Lua
  b.formatting.stylua, --.with { extra_args = { "--indent-type Spaces" } },
  -- b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

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
            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
            vim.lsp.buf.format { bufnr = bufnr }
          end,
        })
      end
    end,
  }
end

return M
