local function harpoon_files()
  local mark = require("harpoon.mark")
  local files = {}
  for idx = 1, mark.get_length() do
    local file = mark.get_marked_file_name(idx)
    if file ~= "" then
      table.insert(files, file)
    end
  end
  return files
end

local function is_harpooned_file(buf_name)
  for _, v in pairs(harpoon_files()) do
    if v == buf_name then
      return 1
    end
  end
  return 0
end

M = require("lualine.components.buffers"):extend()

function M:init(options)
  M.super.init(self, options)
  self.highlights = {
    active = self:create_hl(self.options.buffers_color.active, "active"),
    inactive = self:create_hl(self.options.buffers_color.inactive, "inactive"),
  }
end

function M:buffers()
  local buffers = {}
  M.bufpos2nr = {}

  for b = 1, vim.fn.bufnr("$") do
    if vim.fn.buflisted(b) ~= 0 and is_harpooned_file(vim.api.nvim_buf_get_name(b)) then
      buffers[#buffers + 1] = self:new_buffer(b, #buffers + 1)
      M.bufpos2nr[#buffers] = b
    end
  end

  return buffers
end

return M
