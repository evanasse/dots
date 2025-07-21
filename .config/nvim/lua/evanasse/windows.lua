local M = {}

M.windows = {
  main_editor = {
    win_id = 1000,
  },
  side_terminal = {
    win_id = nil,
    buf_id = nil,
  },
  float_terminal = {
    win_id = nil,
    buf_id = nil,
  },
}

M.on_nvim_start = function()
  local win_width = vim.api.nvim_win_get_width(0)

  M.windows.side_terminal.win_id = vim.api.nvim_open_win(0, false, {
    split = "left",
    win = 0,
    width = math.floor(win_width * 0.4),
  })
  vim.api.nvim_win_call(M.windows.side_terminal.win_id, function()
    vim.cmd("set nocursorline nocursorcolumn nonumber norelativenumber signcolumn=no laststatus=3 | term")
  end)

  M.windows.side_terminal.buf_id = vim.api.nvim_win_get_buf(M.windows.side_terminal.win_id)
end

M.open_float_terminal = function()
  if M.windows.float_terminal.buf_id == nil then
    M.windows.float_terminal.width = math.ceil(math.min(vim.o.columns, math.max(80, vim.o.columns - 20)))
    M.windows.float_terminal.height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines - 10)))
    M.windows.float_terminal.row = math.ceil(vim.o.lines - M.windows.float_terminal.height) * 0.5 - 1
    M.windows.float_terminal.col = math.ceil(vim.o.columns - M.windows.float_terminal.width) * 0.5 - 1

    M.windows.float_terminal.previous_win_id = vim.api.nvim_get_current_win()
    M.windows.float_terminal.win_id = vim.api.nvim_open_win(0, false, {
      relative = "editor",
      row = M.windows.float_terminal.row,
      col = M.windows.float_terminal.col,
      width = M.windows.float_terminal.width,
      height = M.windows.float_terminal.height,
    })
    vim.api.nvim_win_call(M.windows.float_terminal.win_id, function()
      vim.cmd("set nocursorline nocursorcolumn nonumber norelativenumber signcolumn=no laststatus=3 | term")
    end)

    M.windows.float_terminal.buf_id = vim.api.nvim_win_get_buf(M.windows.float_terminal.win_id)

    vim.api.nvim_set_current_win(M.windows.float_terminal.win_id)
  else
    M.windows.float_terminal.previous_win_id = vim.api.nvim_get_current_win()
    M.windows.float_terminal.win_id = vim.api.nvim_open_win(M.windows.float_terminal.buf_id, false, {
      relative = "editor",
      row = M.windows.float_terminal.row,
      col = M.windows.float_terminal.col,
      width = M.windows.float_terminal.width,
      height = M.windows.float_terminal.height,
    })

    vim.api.nvim_set_current_win(M.windows.float_terminal.win_id)
  end
end

M.close_float_terminal = function()
  if M.windows.float_terminal.win_id ~= nil then
    vim.api.nvim_win_close(M.windows.float_terminal.win_id, true)

    if M.windows.float_terminal.previous_win_id ~= nil then
      vim.api.nvim_set_current_win(M.windows.float_terminal.previous_win_id)
    else
      vim.api.nvim_set_current_win(M.windows.main_editor.win_id)
    end
  end
end

M.toggle_float_terminal = function()
  local current_win_id = vim.api.nvim_get_current_win()

  if current_win_id == M.windows.float_terminal.win_id then
    M.close_float_terminal()
  else
    M.open_float_terminal()
  end
end

M.focus_main_editor_or_term = function()
  local current_win_id = vim.api.nvim_get_current_win()

  if current_win_id == M.windows.main_editor.win_id then
    vim.api.nvim_set_current_win(M.windows.side_terminal.win_id)
  elseif current_win_id == M.windows.side_terminal.win_id then
    vim.api.nvim_set_current_win(M.windows.main_editor.win_id)
  elseif current_win_id == M.windows.float_terminal.win_id then
    vim.api.nvim_set_current_win(M.windows.main_editor.win_id)
  end
end

return M
