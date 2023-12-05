local overrides = require "custom.configs.overrides"

return {

  ----------------------------------- default plugins -----------------------------------

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    opts = {
      sources = {
        -- trigger_characters is for unocss lsp
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "crates" },
      },
    },
  },

  -- Show suggestions when executing snippets
  {
    "folke/which-key.nvim",
    cmd = "WhichKey",
  },

  -- Add more lsp servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Diagnostics, code actions, format and more
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
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
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
        },
      }
    end,
    build = ":Neorg sync-parsers",
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },

  --------------------------------- language features ----------------------------------

  -- Debugger
  -- {
  --   "mfussenegger/nvim-dap",
  --   config = function()
  --     require "custom.configs.dap"
  --   end,
  -- },
  --
  -- {
  --   "theHamsta/nvim-dap-virtual-text",
  --   config = function()
  --     require("nvim-dap-virtual-text").setup()
  --   end,
  -- },
  --
  -- {
  --   "rcarriga/nvim-dap-ui",
  -- },
  --
  -- {
  --   "nvim-telescope/telescope-dap.nvim",
  --   config = function()
  --     require("telescope").load_extension "dap"
  --   end,
  -- },

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

  -- LSP utils (rename, code actions, peek definition)
  {
    "jinzhongjia/LspUI.nvim",
    event = "VeryLazy",
    branch = "legacy",
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

  ----------------------------------- custom plugins -----------------------------------

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
      require "custom.configs.zenmode"
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

  -- Show all problems in your code
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TroubleClose", "TroubleRefresh" },
    config = function()
      require("trouble").setup()
    end,
  },

  -- Apply code fixes swiftly
  { "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },

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
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
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
  {
    "ggandor/leap.nvim",
    dependencies = {
      { "tpope/vim-repeat" },
    },
  },

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
      require("modes").setup {
        plugins = {
          presets = {
            operators = false,
          },
        },
      }
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

  -- Easily move lines
  {
    "fedepujol/move.nvim",
    cmd = { "MoveLine", "MoveBlock", "MoveHChar", "MoveHBlock", "MoveWord" },
  },

  -- Move by subwords and skip insignificant punctuation
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
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
      close_fold_kinds = { "imports", "comment" },
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
}
