local overrides = require "custom.plugins.overrides"

return {

  ----------------------------------- default plugins -----------------------------------

  ["goolord/alpha-nvim"] = { disable = false },

  ["folke/which-key.nvim"] = { disable = false, cmd = "WhichKey" },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  ["L3MON4D3/LuaSnip"] = {
    config = function()
      require("plugins.configs.others").luasnip()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { os.getenv "XDG_CONFIG_HOME" .. "/Code/User/snippets" },
      }
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

  -- override default configs
  ["kyazdani42/nvim-tree.lua"] = {
    override_options = overrides.nvimtree,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesitter,
  },

  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },

  ----------------------------------- custom plugins -----------------------------------

  ["wakatime/vim-wakatime"] = {},

  ["Pocco81/true-zen.nvim"] = {
    config = function()
      require "custom.plugins.truezen"
    end,
  },

  ["andweeb/presence.nvim"] = {
    config = function()
      require("presence"):setup { main_image = "file" }
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
    end,
  },

  ["gbprod/cutlass.nvim"] = {
    config = function()
      require("cutlass").setup {
        override_del = true,
      }
    end,
  },

  ["folke/trouble.nvim"] = {
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  },

  ["weilbith/nvim-code-action-menu"] = {
    cmd = "CodeActionMenu",
  },

  ["CRAG666/code_runner.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("code_runner").setup {
        filetype = {
          cpp = 'mkdir -p "$dir/bin" && cd "$dir/bin" && g++ "../$fileName" -o "$fileNameWithoutExt" -fsanitize=address && "./$fileNameWithoutExt"',
        },
        startinsert = true,
      }
    end,
  },
}
