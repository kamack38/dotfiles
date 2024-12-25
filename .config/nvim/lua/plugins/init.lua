---@type NvPluginSpec[]
return {
  ----------------------------------- LSP PLugins -----------------------------------

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
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
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
  {
    "hrsh7th/nvim-cmp",
    url = "https://github.com/iguanacucumber/magazine.nvim",
    opts = {
      sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "crates" },
      },
      experimental = {
        ghost_text = true,
      },
    },
  },

  -- Show all problems in your code
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TroubleClose", "TroubleRefresh" },
    config = function()
      require("trouble").setup()
    end,
  },

  -------------------------------- Language Features --------------------------------

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

  -- LSP utils (rename, code actions, peek definition)
  {
    "jinzhongjia/LspUI.nvim",
    event = "LspAttach",
    branch = "main",
    config = function()
      require("LspUI").setup {
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
      }
    end,
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
    config = function()
      require("template-string").setup()
    end,
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
    ft = "markdown",
    branch = "main",
    config = function()
      local presets = require "markview.presets"
      require("markview").setup {
        modes = { "n", "no", "i" },
        hybrid_modes = { "i" },
        checkboxes = presets.checkboxes.nerd,
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
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
    },
  },

  -- Line decorations
  {
    "svampkorg/moody.nvim",
    event = { "ModeChanged", "BufWinEnter", "WinEnter" },
    dependencies = {
      "NvChad/base46",
    },
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
      disabled_filetypes = { "TelescopePrompt" },
      -- you can turn on or off bold characters for the line numbers
      bold_nr = true,
    },
  },

  -- Show whitespace symbols in visual mode
  {
    "mcauley-penney/visual-whitespace.nvim",
    event = "ModeChanged *:[vV]",
    opts = {
      highlight = { link = "VisualWhitespace" },
    },
  },

  -- Syntax highlighted folds
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "VeryLazy",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
      open_fold_hl_timeout = 200,
      close_fold_kinds_for_ft = {
        default = { "imports", "comment" },
      },
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          -- winhighlight = "Normal:Folded",
          winblend = 0,
        },
      },
      enable_get_fold_virt_text = true,
    },
    init = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldlevel = 40
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function(_, opts)
      local handler = function(virtText, _, endLnum, _, _, ctx)
        local endVirtText = ctx.get_fold_virt_text(endLnum)
        endVirtText[1][1] = endVirtText[1][1]:gsub("^%s*(.-)%s*$", "%1")
        table.insert(virtText, { " ⋯ ", "NonText" })
        for _, chunk in ipairs(endVirtText) do
          table.insert(virtText, chunk)
        end
        return virtText
      end
      opts["fold_virt_text_handler"] = handler
      require("ufo").setup(opts)
    end,
  },

  -- Mark signatures
  {
    "kamack38/marks.nvim",
    event = "VeryLazy",
    config = function()
      require("marks").setup {
        mappings = {
          set = false,
          toggle_mark = "m",
        },
        force_write_shada = true,
      }
    end,
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
    config = function()
      require("nvim-surround").setup {}
    end,
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
    dependencies = {
      { "tpope/vim-repeat" },
    },
  },

  -- Bundle of more than 30 new text objects for Neovim.
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "UIEnter",
    opts = { useDefaultKeymaps = true },
  },

  ------------------------------------- Other ---------------------------------------

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
    config = function()
      require("octo").setup()
    end,
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
    config = function()
      require("neoscroll").setup {
        duration_multiplier = 0.6,
      }
    end,
  },

  -- Organize your work with comments
  {
    "folke/todo-comments.nvim",
    event = { "VeryLazy" },
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- Run code inside NeoVim
  {
    "CRAG666/code_runner.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "RunCode", "RunFile", "RunProject" },
    config = function()
      require("code_runner").setup {
        filetype = {
          cpp = 'cd $dir && mkdir -p "$dir/bin" && g++ "$dir/$fileName" -o "$dir/bin/$fileNameWithoutExt" -std=c++11 -fsanitize=address,undefined && "$dir/bin/$fileNameWithoutExt"',
          tex = 'mkdir -p "$dir/bin" && pdflatex -output-directory="$dir/bin" "$dir/$fileName"',
          rust = 'cargo run "$dir/$fileName"',
        },
        startinsert = true,
      }
    end,
  },

  -- Set project root correctly
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup {
        patterns = { ">.config" },
      }
    end,
  },
}
