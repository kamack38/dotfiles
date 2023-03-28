local overrides = require "custom.plugins.overrides"

return {

  ----------------------------------- default plugins -----------------------------------

  -- Enable dashboard
  ["goolord/alpha-nvim"] = {
    override_options = overrides.alpha(),
    disable = false,
  },

  -- Show suggestions when executing snippets
  ["folke/which-key.nvim"] = {
    disable = false,
    cmd = "WhichKey",
  },

  -- Add more lsp servers
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  -- Load VSC snippets
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
  ["nvim-tree/nvim-tree.lua"] = {
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

  ----------------------------------- syntax plugins -----------------------------------

  -- .rasi
  ["Fymyte/rasi.vim"] = {},

  -- yuck syntax
  ["elkowar/yuck.vim"] = {},

  -- Neorg
  ["nvim-neorg/neorg"] = {
    ft = "norg",
    after = "nvim-treesitter", -- You may want to specify Telescope here as well
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
        },
      }
    end,
    run = ":Neorg sync-parsers",
    requires = "nvim-lua/plenary.nvim",
  },

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

  -- Smooth scrolling
  ["karb94/neoscroll.nvim"] = {
    config = function()
      require("neoscroll").setup()
    end,
  },

  -- Diagnostics, code actions and more
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
        exclude = { "ns", "nS" },
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
          cpp = 'mkdir -p "$dir/bin" && cd "$dir/bin" && g++ "../$fileName" -o "$fileNameWithoutExt" -std=c++11 -fsanitize=address,undefined && "./$fileNameWithoutExt"',
          tex = 'mkdir -p "$dir/bin" && pdflatex -output-directory="$dir/bin" "$dir/$fileName"',
          rust = 'cargo run "$dir/$fileName"',
        },
        startinsert = true,
      }
    end,
  },

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

  -- Cheatsheet
  ["sudormrfbin/cheatsheet.nvim"] = {
    requires = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  },

  -- Fast search plugin
  ["ggandor/leap.nvim"] = {
    requires = {
      { "tpope/vim-repeat" },
    },
  },

  -- Set project root correctly
  ["ahmedkhalf/project.nvim"] = {
    config = function()
      require("project_nvim").setup {}
    end,
  },

  -- Line decorations
  ["mvllow/modes.nvim"] = {
    config = function()
      require("modes").setup()
    end,
  },
}
