require "nvchad.options"

local opt = vim.opt

if vim.fn.has "win32" == 1 then
  opt.shell = "pwsh.exe -nol"
  opt.shellcmdflag = "-nop -c"
  opt.shellquote = '"'
  opt.shellxquote = ""
  opt.shellpipe = "| Out-File -Encoding UTF8 %s"
  opt.shellredir = "| Out-File -Encoding UTF8 %s"
end

-- Folds
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldlevel = 20
-- opt.fillchars = { fold = " ", eob = " " }

opt.conceallevel = 2
opt.cmdheight = 0
opt.scrolloff = 5
opt.updatetime = 100

local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
    or get_option(filetype, option)
end

if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font Mono Med:h12"

  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end

  vim.g.neovide_transparency = 0.8
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#282c34" .. alpha()
  vim.o.background = ""
  -- vim.keymap.set("i", "<c-s-v>", "<c-r>+")
  -- vim.keymap.set("i", "<c-r>", "<c-s-v>")
end
