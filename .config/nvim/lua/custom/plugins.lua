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
    event = "VeryLazy",
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
  { "Fymyte/rasi.vim", ft = "rasi" },

  -- yuck syntax
  {
    "elkowar/yuck.vim",
    ft = "yuck",
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
    cmd = { "TZAtaraxis", "TZMinimalist", "TZFocus", "TZNarrow" },
    config = function()
      require "custom.configs.truezen"
    end,
  },

  -- Let everyone know your using NeoVim
  {
    "andweeb/presence.nvim",
    lazy = false,
    config = function()
      require("presence"):setup { main_image = "file" }
    end,
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup()
    end,
  },

  -- Organize your work with comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- Delete without copying
  {
    "gbprod/cutlass.nvim",
    lazy = false,
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
    cmd = "Trouble",
    config = function()
      require("trouble").setup()
    end,
  },

  -- Apply code fixes swiftly
  { "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },

  -- Run code inside NeoVim
  {
    "CRAG666/code_runner.nvim",
    dependecies = "nvim-lua/plenary.nvim",
    cmd = { "RunCode", "RunFile", "RunProject" },
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
  {
    "yehuohan/marks.nvim",
    lazy = false,
    config = function()
      require("marks").setup {
        default_mappings = false,
        force_write_shada = true,
      }
    end,
  },

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
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  -- Cheatsheet
  {
    "sudormrfbin/cheatsheet.nvim",
    cmd = "Cheatsheet",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  },

  -- Fast search plugin
  { "ggandor/leap.nvim", dependencies = {
    { "tpope/vim-repeat" },
  } },

  -- Set project root correctly
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup()
    end,
  },

  -- Line decorations
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = function()
      require("modes").setup()
    end,
  },

  -- Template string converter
  {
    "axelvc/template-string.nvim",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact", "python" },
    config = function()
      require("template-string").setup()
    end,
  },

  -- Easily move lines
  {
    "fedepujol/move.nvim",
    cmd = { "MoveLine", "MoveBlock", "MoveHChar", "MoveHBlock", "MoveWord" },
  },

  -- Easier crates.io dependency managing
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        popup = {
          autofocus = true,
        },
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }
    end,
  },

  -- Quicker NPM package managing
  {
    "vuki656/package-info.nvim",
    event = { "BufRead package.json" },
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("package-info").setup()
    end,
  },
}
