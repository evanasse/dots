local harpoon_utils = require("harpoon.utils")
local mark = require("harpoon.mark")

local function harpoon_files()
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
      return true
    end
  end
  return false
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
    local valid_buf_id, buf_name = pcall(vim.api.nvim_buf_get_name, b)

    if valid_buf_id and buf_name ~= "" then
      local norm_buf_name = harpoon_utils.normalize_path(buf_name)

      if is_harpooned_file(norm_buf_name) then
        local harpoon_idx = mark.get_index_of(norm_buf_name)

        buffers[harpoon_idx] = self:new_buffer(b, harpoon_idx)
        M.bufpos2nr[harpoon_idx] = b
      end
    end
  end

  return buffers
end

return M
