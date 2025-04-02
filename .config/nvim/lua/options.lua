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
vim.o.foldenable = true
vim.o.foldlevel = 40
vim.o.foldlevelstart = 99
vim.o.foldcolumn = "0" -- Change to "auto:9"
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "", lastline = " " }

-- Enables folding with syntax highlight
-- eg.: function() { ⋯ }
local function fold_virt_text(result, s, lnum, coloff)
  if not coloff then
    coloff = 0
  end
  local text = ""
  local hl
  for i = 1, #s do
    local char = s:sub(i, i)
    local hls = vim.treesitter.get_captures_at_pos(0, lnum, coloff + i - 1)
    local _hl = hls[#hls]
    if _hl then
      local new_hl = "@" .. _hl.capture
      if new_hl ~= hl then
        table.insert(result, { text, hl })
        text = ""
        hl = nil
      end
      text = text .. char
      hl = new_hl
    else
      text = text .. char
    end
  end
  table.insert(result, { text, hl })
end

function _G.virtual_foldtext()
  local start = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
  local end_str = vim.fn.getline(vim.v.foldend)
  local end_ = vim.trim(end_str)
  local result = {}
  fold_virt_text(result, start, vim.v.foldstart - 1)
  table.insert(result, { " ⋯ ", "Delimiter" })
  fold_virt_text(result, end_, vim.v.foldend - 1, #(end_str:match("^(%s+)") or ""))
  return result
end

vim.opt.foldtext = "v:lua.virtual_foldtext()"

-- Snippets
local config_path = ((os.getenv "XDG_CONFIG_HOME") or (os.getenv "APPDATA") or os.getenv "HOME" .. "/.config")
vim.g.vscode_snippets_path = config_path .. "/Code/User/snippets"

opt.conceallevel = 2
-- opt.cmdheight = 0
opt.scrolloff = 5
opt.updatetime = 100

-- Enable modes.nvim
vim.o.cursorlineopt = "both"

-- Set hyprlang filetype
vim.filetype.add {
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
}

-- Disable recommended markdown style
vim.g.markdown_recommended_style = 0

if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font Mono Med:h12"

  local alpha = function()
    return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
  end

  vim.g.neovide_refresh_rate = 120
  vim.g.neovide_transparency = 0.8
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#282c34" .. alpha()
end
