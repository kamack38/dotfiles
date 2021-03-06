return {
   ["goolord/alpha-nvim"] = { disable = false, },
   ["wakatime/vim-wakatime"] = {},
   ["Pocco81/TrueZen.nvim"] = {
      cmd = {
         "TZAtaraxis",
         "TZMinimalist",
         "TZFocus",
      },
      config = function()
         require "custom.plugins.truezen"
      end,
   },
   ["andweeb/presence.nvim"] = {
      config = function()
         require("presence"):setup({ main_image = "file" })
      end,
   },
   ["nvim-telescope/telescope-media-files.nvim"] = {
      after = "telescope.nvim",
      config = function()
         require("telescope").setup {
            extensions = {
               media_files = {
                  filetypes = { "png", "webp", "jpg", "jpeg" },
                  find_cmd = "fd", -- find command (defaults to `fd`)
               },
            },
         }
         require("telescope").load_extension "media_files"
      end,
   },
   ["karb94/neoscroll.nvim"] = {
      config = function()
         require("neoscroll").setup()
      end,
   },
   ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.null-ls").setup()
      end,
   },
   ["folke/todo-comments.nvim"] = {
     requires = "nvim-lua/plenary.nvim",
     config = function()
       require("todo-comments").setup()
     end
   }
}
