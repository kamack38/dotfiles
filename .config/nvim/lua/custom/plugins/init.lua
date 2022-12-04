local overrides = require "custom.plugins.overrides"

return {

  ----------------------------------- default plugins -----------------------------------

  ["goolord/alpha-nvim"] = {
    override_options = overrides.alpha(),
    disable = false,
  },

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

  -- ["NvChad/ui"] = {
  --   override_options = {
  --     tabufline = {
  --       lazyload = false, -- to show tabufline by default
  --       overriden_modules = function()
  --         return require "custom.plugins.ui"
  --       end,
  --     },
  --   },
  -- },

  ----------------------------------- custom plugins -----------------------------------

  -- Track the time you're spending with your code
  ["wakatime/vim-wakatime"] = {},

  -- Focus on your code
  ["Pocco81/true-zen.nvim"] = {
    config = function()
      require "custom.plugins.truezen"
    end,
  },

  -- Let everyone know your using NeoVim
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

  -- Organize your work with comments
  ["folke/todo-comments.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- Delete without copying
  ["gbprod/cutlass.nvim"] = {
    config = function()
      require("cutlass").setup {
        override_del = true,
      }
    end,
  },

  -- Show all problems in your code
  ["folke/trouble.nvim"] = {
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  },

  -- Apply code fixes swiftly
  ["weilbith/nvim-code-action-menu"] = {
    cmd = "CodeActionMenu",
  },

  -- Run code inside NeoVim
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

  -- Headband
  -- ["B4mbus/nvim-headband"] = {
  --   requires = {
  --     { "SmiteshP/nvim-navic" }, -- required for for the navic section to work
  --     { "kyazdani42/nvim-web-devicons" }, -- required for for devicons and default location_section.separator highlight group
  --   },
  --   config = function()
  --     require("nvim-headband").setup {
  --       file_section = {
  --         enable = false,
  --       },
  --       location_section = {
  --         enable = true,
  --
  --         --   wrap = bubbles_wrap,
  --         --
  --         --   separator = reverse_arrow,
  --         --
  --         --   empty_symbol = "",
  --         --
  --         --   position = "right",
  --       },
  --     }
  --   end,
  -- },

  -- Mark signatures
  ["kshenoy/vim-signature"] = {},

  -- Markdown browser preview
  ["iamcco/markdown-preview.nvim"] = {
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Surround text with quotes
  ["kylechui/nvim-surround"] = {
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  -- yuck syntax
  ["elkowar/yuck.vim"] = {},
}
