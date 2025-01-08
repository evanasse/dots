-- Statusline
local colors = require("chalet_colors")
local statusline = {}

statusline.normal = {
  a = { fg = colors.bg, bg = colors.dark_purple },
  b = { fg = colors.light_brown, bg = nil },
  c = { fg = colors.white, bg = nil },
}

statusline.insert = {
  a = { fg = colors.bg, bg = colors.dark_orange },
  b = { fg = colors.light_brown, bg = nil },
  c = { fg = colors.white, bg = nil },
}

statusline.visual = {
  a = { fg = colors.bg, bg = colors.dark_red },
  b = { fg = colors.light_brown, bg = nil },
  c = { fg = colors.white, bg = nil },
}

statusline.replace = {
  a = { fg = colors.bg, bg = colors.light_red },
  b = { fg = colors.light_brown, bg = nil },
  c = { fg = colors.white, bg = nil },
}

statusline.command = {
  a = { fg = colors.bg, bg = colors.dark_green },
  b = { fg = colors.light_brown, bg = nil },
  c = { fg = colors.white, bg = nil },
}

statusline.inactive = {
  a = { fg = colors.light_brown, bg = colors.black },
  b = { fg = colors.light_brown, bg = nil },
  c = { fg = colors.light_brown, bg = nil },
}

local function lsp_client_names()
  local client_names = {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    table.insert(client_names, client.name)
  end

  local names = table.concat(client_names, ",")
  if names ~= "" then
    names = "[" .. names .. "]"
  end

  return names
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = statusline,
    component_separators = '',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 100,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
      {
        'mode',
      }
    },
    lualine_b = {
      {
        'branch',
      },
      {
        'diagnostics',
        diagnostics_color = {
          -- Same values as the general color option can be used here.
          error = 'DiagnosticError', -- Changes diagnostics' error color.
          warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
          info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
          hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
        },
        symbols = { error = " ", warn = " ", info = " ", hint = "󰦤 " }
      },
    },
    lualine_c = {
      '%=',
      {
        'filename',
        file_status = true,
        path = 3,
        symbols = {
          modified = '*',
          readonly = ' ',
          unnamed = '[No Name]',
          newfile = '[New]',
        },
        color = StatusLine,
      },
    },
    lualine_x = {},
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      -- {
      --   require("noice").api.statusline.mode.get,
      --   cond = require("noice").api.statusline.mode.has,
      -- }
    },
    lualine_b = {
    },
    lualine_c = {
      '%=',
      {
        require("evanasse.lualine.custom_components.harpoon_buffers"),
        mode = 0,
        icons_enabled = false,
        buffers_color = {
          -- Same values as the general color option can be used here.
          active = { fg = colors.bg, bg = colors.dark_purple }, -- Color for active buffer.
          inactive = { fg = colors.dark_brown, bg = "none" },   -- Color for inactive buffer.
        },
        symbols = {
          modified = '*', -- Text to show when the buffer is modified
          alternate_file = '', -- Text to show to identify the alternate file
          directory = '', -- Text to show when the buffer is a directory
        },
        color = { bg = 'none' }
      },
    },
    lualine_x = {
      {
        'lsp_progress',
        display_components = { 'spinner', {} },
        color = { fg = colors.white },
        separators = {
          component = '',
          progress = '',
        },
        spinner_symbols = require("evanasse.spinner").half_spinner_rev(),
        timer = { spinner = 50 }
      }
    },
    lualine_y = {
      lsp_client_names
    },
    lualine_z = {
    }
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
