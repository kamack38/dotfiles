local servers = {
  bashls = {},
  clangd = {},
  cssls = {},
  -- emmet_ls = {},
  html = {},
  -- nil_ls = {},
  ruff = {},
  tailwindcss = {},
  -- texlab = {},
  -- ts_ls = {},
  marksman = {},
  -- ltex_plus = {
  --   settings = {
  --     language = "pl-PL"
  --   }
  -- },
  ocamllsp = {},
  sqruff = {},
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
    workspace_required = false,
  },
  tinymist = {
    single_file_support = true,
    settings = {
      exportPdf = "onSave",
      outputPath = "$root/target/$dir/$name",
    },
  },
}

-- Check if clang-format has extend fallback-style support
local lines = vim.fn.systemlist({ "clang-format", "--help" })
local count = 0

for _, line in ipairs(lines) do
  if line:match("%-%-fallback%-style") then
    count = count + 1
  end
end

if count >= 5 then
  servers.clangd.cmd = { "clangd", "--fallback-style=file:" .. os.getenv("HOME") .. "/.config/clang-format" }
end

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
