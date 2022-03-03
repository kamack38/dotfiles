return {
   { "wakatime/vim-wakatime" },
   { "Pocco81/TrueZen.nvim" },
   {
      "andweeb/presence.nvim",
      config = function()
            require("presence"):setup({ main_image = "file" })
      end,
   },
   {
      "williamboman/nvim-lsp-installer",
      config = function()
         require "custom.plugins.lspconfig"
      end,

      -- lazy load!
      setup = function()
         require("core.utils").packer_lazy_load "nvim-lsp-installer"
         -- reload the current file so lsp actually starts for it
         vim.defer_fn(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
         end, 0)
      end,
      opt = true,
   },
   {
      "karb94/neoscroll.nvim",
      opt = true,
      config = function()
         require("neoscroll").setup()
      end,
      -- lazy loading
      setup = function()
         require("core.utils").packer_lazy_load "neoscroll.nvim"
      end,
   },
   {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.null-ls").setup()
      end,
   }
}
