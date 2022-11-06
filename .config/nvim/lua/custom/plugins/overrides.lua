local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "html",
    "css",
    "javascript",
    "typescript",
    "json",
    "yaml",
    "toml",
    "markdown",
    "c",
    "cpp",
    "bash",
    "fish",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    -- spelling
    "cspell",

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
}

M.alpha = function()
  local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 36,
      align_shortcut = "right",
      hl = "AlphaButtons",
    }

    if keybind then
      opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
    end

    return {
      type = "button",
      val = txt,
      on_press = function()
        local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
        vim.api.nvim_feedkeys(key, "normal", false)
      end,
      opts = opts,
    }
  end
  return {
    buttons = {
      type = "group",
      val = {
        button("SPC f f", "  Find File  ", ":Telescope find_files<CR>"),
        button("SPC f o", "  Recent File  ", ":Telescope oldfiles<CR>"),
        button("SPC f w", "  Find Word  ", ":Telescope live_grep<CR>"),
        button("SPC n f", "  New Buffer", ":enew<CR>"),
        button("SPC b m", "  Bookmarks  ", ":Telescope marks<CR>"),
        button("SPC t h", "  Themes  ", ":Telescope themes<CR>"),
        button("SPC e s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
      },
    },
  }
end

return M
