---@type NvPluginSpec[]
return {
  ----------------------------------- LSP Plugins -----------------------------------

  -- Add more lsp servers
  {
    "neovim/nvim-lspconfig",
    config = function()
      dofile(vim.g.base46_cache .. "lsp")
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require "configs.conform"
    end,
  },

  -- Format parsing
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",

        "json",
        "jsonc",
        "yaml",
        "toml",

        "c",
        "cpp",
        "python",
        "rust",
        "nix",
        "bash",
        "fish",

        "lua",
        "vim",
        "markdown",
        "typst",
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          node_decremental = "grm",
          scope_incremental = "grc",
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
          },
          selection_modes = {
            ["@parameter.outer"] = "v", -- char wise
            ["@function.outer"] = "V", -- line wise
            ["@class.outer"] = "<c-v>", -- block wise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = true,
        },
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },

  -- Auto close and auto rename html tag
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Autocompletion
  { import = "nvchad.blink.lazyspec" },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   url = "https://github.com/iguanacucumber/magazine.nvim",
  --   opts = {
  --     sources = {
  --       { name = "luasnip" },
  --       { name = "nvim_lsp" },
  --       { name = "buffer" },
  --       { name = "nvim_lua" },
  --       { name = "path" },
  --       { name = "crates" },
  --     },
  --     experimental = {
  --       ghost_text = true,
  --     },
  --   },
  -- },

  -- Show all problems in your code
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TroubleClose", "TroubleRefresh" },
    config = function()
      dofile(vim.g.base46_cache .. "trouble")
      require("trouble").setup()
    end,
  },

  -------------------------------- Language Features --------------------------------

  -- Easier crates.io dependency managing
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      popup = {
        autofocus = true,
      },
    },
  },

  -- Quicker NPM package managing
  {
    "vuki656/package-info.nvim",
    event = { "BufRead package.json" },
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },

  -- LSP utils (rename, code actions, peek definition)
  {
    "jinzhongjia/LspUI.nvim",
    event = "LspAttach",
    branch = "main",
    opts = {
      prompt = false,
      code_action = {
        enable = true,
        command_enable = true,
        icon = "💡",
        keybind = {
          exec = "<CR>",
          prev = "k",
          next = "j",
          quit = "q",
        },
      },
    },
  },

  -- Typst highlighting
  {
    "kaarmu/typst.vim",
    ft = "typst",
    config = function()
      vim.g.typst_conceal_math = 1
      vim.g.typst_conceal_emoji = 1
      vim.g.typst_conceal = 1
    end,
  },

  -- Markdown browser preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Template string converter
  {
    "axelvc/template-string.nvim",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact", "python", "html" },
    opts = {},
  },

  -- TS context aware comments
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },

  -- Markdown previewer
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "typst", "Avante" },
    config = function()
      local presets = require "markview.presets"
      require("markview").setup {
        preview = {
          modes = { "n", "no", "i" },
          hybrid_modes = { "i" },
        },
        checkboxes = presets.checkboxes.nerd,
        markdown_inline = {
          hyperlinks = {
            ["neovim%.io"] = {
              priority = 9999,
              icon = " ",
              hl = "MarkviewPalette4Fg",
            },
          },
        },
      }
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  --------------------------------------- UI ----------------------------------------

  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        enable = true,
        ignore = false,
      },
      renderer = {
        icons = {
          git_placement = "after",
          glyphs = {
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "",
              untracked = "",
              deleted = "",
              ignored = "",
            },
          },
        },
      },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    },
  },

  -- Line decorations
  {
    "svampkorg/moody.nvim",
    event = { "ModeChanged", "BufWinEnter", "WinEnter" },
    opts = {
      blends = {
        normal = 0.15,
        insert = 0.15,
        visual = 0.20,
        command = 0.2,
        operator = 0.2,
        replace = 0.2,
        select = 0.2,
        terminal = 0.2,
        terminal_n = 0.2,
      },
      colors = {
        normal = "#00BFFF",
        insert = "#78CCC5",
        visual = "#AD6FF7",
        command = "#EB788B",
        operator = "#FF8F40",
        replace = "#E66767",
        select = "#AD6FF7",
        terminal = "#4CD4BD",
        terminal_n = "#00BBCC",
      },
      -- disable filetypes here. Add for example "TelescopePrompt" to
      -- not have any coloured cursorline for the telescope prompt.
      disabled_filetypes = { "TelescopePrompt", "nvdash" },
      -- you can turn on or off bold characters for the line numbers
      bold_nr = true,
    },
  },

  -- Show whitespace symbols in visual mode
  {
    "mcauley-penney/visual-whitespace.nvim",
    event = "ModeChanged *:[vV\22]",
  },

  -- Mark signatures
  {
    "2KAbhishek/markit.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = {
        set = false,
        toggle_mark = "m",
      },
    },
  },

  -- Remove the press enter prompt
  {
    "jake-stewart/auto-cmdheight.nvim",
    lazy = false,
    opts = {
      -- max cmdheight before displaying hit enter prompt.
      max_lines = 5,

      -- number of seconds until the cmdheight can restore.
      duration = 2,

      -- whether key press is required to restore cmdheight.
      remove_on_key = true,

      -- always clear the cmdline after duration and key press.
      -- by default it will only happen when cmdheight changed.
      clear_always = false,
    },
  },

  ------------------------------------ Bindings -------------------------------------

  -- Delete without copying
  {
    "gbprod/cutlass.nvim",
    lazy = false,
    opts = {
      override_del = true,
    },
  },

  -- Surround text with quotes
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  -- Easily move lines
  {
    "fedepujol/move.nvim",
    opts = {},
    cmd = { "MoveLine", "MoveBlock", "MoveHChar", "MoveHBlock", "MoveWord" },
  },

  -- Move by subwords and skip insignificant punctuation
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
  },

  -- Fast search plugin
  {
    "ggandor/leap.nvim",
    config = function()
      dofile(vim.g.base46_cache .. "leap")
      require("leap").setup {}
    end,
    dependencies = {
      { "tpope/vim-repeat" },
    },
  },

  -- Bundle of more than 30 new text objects for Neovim.
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "UIEnter",
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
  },

  ------------------------------------- Other ---------------------------------------

  -- AI features
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   version = false,
  --   config = function()
  --     dofile(vim.g.base46_cache .. "avante")
  --     require("configs.avante")
  --   end,
  --   build = "make",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "hrsh7th/nvim-cmp",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },

  -- Nerdfont symbol picker
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },

  -- GitHub integration
  {
    "pwntester/octo.nvim",
    keys = require("configs.octo").keys,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Octo" },
    opts = {},
  },

  -- Track the time you're spending with your code
  {
    "wakatime/vim-wakatime",
    event = { "VeryLazy" },
  },

  -- Focus on your code
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require "configs.zenmode"
    end,
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    keys = { "<C-d>", "<C-u>" },
    opts = {
      duration_multiplier = 0.6,
    },
  },

  -- Organize your work with comments
  {
    "folke/todo-comments.nvim",
    event = { "VeryLazy" },
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      dofile(vim.g.base46_cache .. "todo")
      require("todo-comments").setup()
    end,
  },

  -- Run code inside NeoVim
  {
    "CRAG666/code_runner.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "RunCode", "RunFile", "RunProject" },
    opts = {
      filetype = {
        cpp = 'cd "$dir" && mkdir -p "$dir/bin" && g++ "$dir/$fileName" -o "$dir/bin/$fileNameWithoutExt" -std=c++11 -fsanitize=address,undefined && "$dir/bin/$fileNameWithoutExt"',
        tex = 'mkdir -p "$dir/bin" && pdflatex -output-directory="$dir/bin" "$dir/$fileName"',
        rust = 'cargo run "$dir/$fileName"',
      },
      startinsert = true,
    },
  },

  -- Set project root correctly
  {
    "DrKJeff16/project.nvim",
    lazy = false,
    enabled = function()
      return vim.fn.has "win32" == 0
    end,
    config = function()
      require("project_nvim").setup {
        patterns = { ">.config" },
      }
    end,
  },
}
