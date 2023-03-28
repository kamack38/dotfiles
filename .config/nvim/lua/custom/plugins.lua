local overrides = require "custom.configs.overrides"

return {

  ----------------------------------- default plugins -----------------------------------

  -- Show suggestions when executing snippets
  {
    "folke/which-key.nvim",
    disable = false,
    cmd = "WhichKey",
  },

  -- Add more lsp servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Diagnostics, code actions and more
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("custom.configs.null-ls").setup()
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- Preview media files in Telescope
  {
    "nvim-telescope/telescope-media-files.nvim",
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
  { "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },

  { "nvim-treesitter/nvim-treesitter", opts = overrides.treesitter },

  { "williamboman/mason.nvim", opts = overrides.mason },

  ----------------------------------- syntax plugins -----------------------------------

  -- .rasi
  { "Fymyte/rasi.vim" },

  -- yuck syntax
  {
    "elkowar/yuck.vim",
    config = function()
      vim.opt.ft = "yuck"
    end,
  },

  -- Neorg
  {
    "nvim-neorg/neorg",
    ft = "norg",
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
        },
      }
    end,
    build = ":Neorg sync-parsers",
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },

  ----------------------------------- custom plugins -----------------------------------

  -- Track the time you're spending with your code
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  -- Focus on your code
  {
    "Pocco81/true-zen.nvim",
    config = function()
      require "custom.plugins.truezen"
    end,
  },

  -- Let everyone know your using NeoVim
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence"):setup { main_image = "file" }
    end,
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      require("neoscroll").setup()
    end,
  },

  -- Organize your work with comments
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- Delete without copying
  {
    "gbprod/cutlass.nvim",
    config = function()
      require("cutlass").setup {
        override_del = true,
        exclude = { "ns", "nS" },
      }
    end,
  },

  -- Show all problems in your code
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  },

  -- Apply code fixes swiftly
  { "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },

  -- Run code inside NeoVim
  {
    "CRAG666/code_runner.nvim",
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
  { "kshenoy/vim-signature", lazy = false },

  -- Markdown browser preview
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Surround text with quotes
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  -- Cheatsheet
  {
    "sudormrfbin/cheatsheet.nvim",
    lazy = false,
    requires = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  },

  -- Fast search plugin
  { "ggandor/leap.nvim", requires = {
    { "tpope/vim-repeat" },
  } },

  -- Set project root correctly
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
    end,
  },

  -- Line decorations
  {
    "mvllow/modes.nvim",
    config = function()
      require("modes").setup()
    end,
  },
}
