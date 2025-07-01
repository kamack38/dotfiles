local servers = {
  bashls = {},
  clangd = {},
  cssls = {},
  -- emmet_ls = {},
  html = {},
  -- nil_ls = {},
  ruff = {},
  -- tailwindcss = {},
  -- texlab = {},
  ts_ls = {},
  -- ltex_plus = {
  --   settings = {
  --     language = "pl-PL"
  --   }
  -- },
  kotlin_lsp = {},
  rust_analyzer = {
    filetypes = { "rust" },
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = {
        enable = true,
        command = "clippy",
        features = "all",
      },
      procMacro = {
        enable = true,
      },
    },
  },
  biome = {
    single_file_support = true,
  },
  tinymist = {
    single_file_support = true,
    settings = {
      exportPdf = "onType",
      outputPath = "$root/target/$dir/$name",
    },
  },
}

for name, opts in pairs(servers) do
  vim.lsp.enable(name)
  vim.lsp.config(name, opts)
end
