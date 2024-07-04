return {
  ----------------------------------- LSP PLugins -----------------------------------

  -- Add more lsp servers
  {
    "neovim/nvim-lspconfig",
    config = function()
      dofile(vim.g.base46_cache .. "lsp")
      require "nvchad.configs.lspconfig"
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
        "vim",
        "html",
        "css",
        "rust",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "yaml",
        "toml",
        "markdown",
        "c",
        "nix",
        "cpp",
        "bash",
        "fish",
        "lua",
        "rasi",
        "python",
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    },
  },

  -- Autotags
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

  -- LSP installer
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- web dev
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "emmet-ls",
        "json-lsp",

        -- shell
        "shfmt",
        "shellcheck",

        -- cpp
        "clangd",

        -- lua
        "stylua",
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

  --------------------------------------- UI ----------------------------------------

  -- Show suggestions when executing snippets
  {
    "folke/which-key.nvim",
    cmd = "WhichKey",
  },

  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        enable = true,
        ignore = false,
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
    },
  },

  -- Line decorations
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = function()
      require("modes").setup {
        plugins = {
          presets = {
            operators = false,
          },
        },
      }
    end,
  },

  -- Show whitespace symbols in visual mode
  {
    "mcauley-penney/visual-whitespace.nvim",
    event = "VeryLazy",
    config = function()
      get_hl_hex = function(opts, ns_id)
        opts, ns_id = opts or {}, ns_id or 0
        assert(opts.name or opts.id, "Error: must have hl group name or ID!")
        opts.link = true

        local hl = vim.api.nvim_get_hl(ns_id, opts)

        return {
          fg = hl.fg and ("#%06x"):format(hl.fg),
          bg = hl.bg and ("#%06x"):format(hl.bg),
        }
      end
      local ws_bg = get_hl_hex({ name = "ModesVisualVisual" })["bg"]
      local ws_fg = get_hl_hex({ name = "Comment" })["fg"]

      require("visual-whitespace").setup {
        highlight = { bg = ws_bg, fg = ws_fg },
        use_listchars = true,
        nl_char = "¬",
      }
    end,
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
    "yehuohan/marks.nvim",
    lazy = false,
    config = function()
      require("marks").setup {
        default_mappings = false,
        force_write_shada = true,
      }
    end,
  },

  ------------------------------------ Bindings -------------------------------------

  -- Delete without copying
  {
    "gbprod/cutlass.nvim",
    lazy = false,
    config = function()
      require("cutlass").setup {
        override_del = true,
      }
    end,
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

  ------------------------------------- Other ---------------------------------------

  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },

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
    lazy = false,
  },

  -- Focus on your code
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require "configs.zenmode"
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
    keys = { "<C-d>", "<C-u>" },
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

  -- Run code inside NeoVim
  {
    "CRAG666/code_runner.nvim",
    dependencies = "nvim-lua/plenary.nvim",
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
