local M = {}

local function is_upper(char)
  return (65 <= char:byte() and char:byte() <= 90)
end

local function is_lower(char)
  return (97 <= char:byte() and char:byte() <= 122)
end

local function is_letter(char)
  return is_upper(char) or is_lower(char)
end

local function pick(a, b, cmp)
  for i, v in ipairs(a) do
    if cmp(v, b[i]) then
      return a
    elseif cmp(b[i], v) then
      return b
    end
  end
  return b
end

function M.expand_height()
  local win_id = vim.api.nvim_get_current_win()
  local current_height = vim.api.nvim_win_get_height(win_id)

  if vim.b.max_height == nil then
    vim.b.max_height = 100
  end

  if current_height ~= vim.b.max_height then
    vim.b.default_height = current_height
    vim.api.nvim_win_set_height(win_id, vim.b.max_height)
    vim.b.max_height = vim.api.nvim_win_get_height(win_id)
  else
    vim.api.nvim_win_set_height(win_id, vim.b.default_height)
  end
end

function M.expand_width()
  local win_id = vim.api.nvim_get_current_win()
  local current_width = vim.api.nvim_win_get_width(win_id)

  if vim.b.max_width == nil then
    vim.b.max_width = 999
  end

  if current_width ~= vim.b.max_width then
    vim.b.default_width = current_width
    vim.api.nvim_win_set_width(win_id, vim.b.max_width)
    vim.b.max_width = vim.api.nvim_win_get_width(win_id)
  else
    vim.api.nvim_win_set_width(win_id, vim.b.default_width)
  end
end

function M.open_next_link()
  require("various-textobjs").url()

  -- plugin only switches to visual mode when textobj is found
  local foundURL = vim.fn.mode():find "v"
  if not foundURL then
    vim.cmd("tag " .. vim.fn.expand "<cword>")
    return
  end

  local url = vim.fn.getregion(vim.fn.getpos ".", vim.fn.getpos "v", { type = "v" })[1]
  vim.ui.open(url)
  vim.cmd.normal { "v", bang = true }
end

function M.toggle_mark()
  local input = vim.fn.getchar()
  local char = vim.fn.nr2char(input)

  if not is_letter(char) then
    return
  end

  local line = vim.api.nvim_win_get_cursor(0)[1]
  local pos = vim.api.nvim_buf_get_mark(0, char)
  local row, _ = unpack(pos)
  if row ~= line then
    vim.api.nvim_feedkeys("m" .. char, "n", true)
  else
    vim.api.nvim_buf_del_mark(0, char)
  end

  vim.schedule(function()
    require("guttermarks").refresh()
  end)
end

function M.delete_mark()
  local input = vim.fn.getchar()
  local char = vim.fn.nr2char(input)

  if not is_letter(char) then
    vim.api.nvim_feedkeys("dm" .. input, "n", true)
    return
  end

  vim.api.nvim_buf_del_mark(0, char)
  vim.schedule(function()
    require("guttermarks").refresh()
  end)
end

function M.delete_marks_on_line()
  local buf = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1]

  for _, m in ipairs(vim.fn.getmarklist(buf)) do
    if m.pos[2] == line and is_lower(m.mark:sub(2)) then
      vim.api.nvim_buf_del_mark(buf, m.mark:sub(2))
    end
  end

  for _, m in ipairs(vim.fn.getmarklist()) do
    if m.pos[1] == buf and m.pos[2] == line and is_upper(m.mark:sub(2)) then
      vim.api.nvim_del_mark(m.mark:sub(2))
    end
  end
  require("guttermarks").refresh()
end

function M.delete_all_marks()
  local buf = vim.api.nvim_get_current_buf()

  for _, m in ipairs(vim.fn.getmarklist(buf)) do
    if is_lower(m.mark:sub(2)) then
      vim.api.nvim_buf_del_mark(buf, m.mark:sub(2))
    end
  end

  for _, m in ipairs(vim.fn.getmarklist()) do
    if m.pos[1] == buf and is_upper(m.mark:sub(2)) then
      vim.api.nvim_del_mark(m.mark:sub(2))
    end
  end
  require("guttermarks").refresh()
end

function M.jump_next_mark()
  local buf = vim.api.nvim_get_current_buf()
  local marks = vim.fn.getmarklist(buf)
  local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
  local function cmp(a, b)
    return a < b
  end
  local next_mark = { math.huge, math.huge }
  for _, mark in ipairs(marks) do
    local _, mark_row, mark_col = unpack(mark.pos)
    if is_lower(mark.mark:sub(2)) then
      if mark_row > cursor_row then
        next_mark = pick(next_mark, { mark_row, mark_col - 1 }, cmp)
      elseif mark_row == cursor_row and mark_col > cursor_col + 1 then
        next_mark = pick(next_mark, { mark_row, mark_col - 1 }, cmp)
      end
    end
    if next_mark[1] ~= math.huge and next_mark[2] ~= math.huge then
      vim.api.nvim_win_set_cursor(0, next_mark)
    end
  end
end

function M.jump_prev_mark()
  local buf = vim.api.nvim_get_current_buf()
  local marks = vim.fn.getmarklist(buf)
  local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
  local next_mark = { -1, -1 }
  local function cmp(a, b)
    return a > b
  end
  for _, mark in ipairs(marks) do
    local _, mark_row, mark_col = unpack(mark.pos)
    if is_lower(mark.mark:sub(2)) then
      if mark_row < cursor_row then
        next_mark = pick(next_mark, { mark_row, mark_col - 1 }, cmp)
      elseif mark_row == cursor_row and mark_col < cursor_col + 1 then
        next_mark = pick(next_mark, { mark_row, mark_col - 1 }, cmp)
      end
    end
    if next_mark[1] ~= -1 and next_mark[2] ~= -1 then
      vim.api.nvim_win_set_cursor(0, next_mark)
    end
  end
end

function M.hover_handler()
  local dap_ok, dap = pcall(require, "dap")
  if dap_ok and dap.session() ~= nil then
    local dapui_ok, dapui = pcall(require, "dap.ui.widgets")
    if dapui_ok and vim.bo.filetype ~= "dap-float" then
      dapui.hover(nil, { border = "rounded" })
    end
  end
  local ft = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, ft) then
    vim.cmd("silent! h " .. vim.fn.expand("<cword>"))
  elseif vim.tbl_contains({ "man" }, ft) then
    vim.cmd("silent! Man " .. vim.fn.expand("<cword>"))
  else
    vim.lsp.buf.hover({
      border = "rounded",
      silent = true,
      winopts = {
        conceallevel = 3,
      },
    })
  end
end

return M
