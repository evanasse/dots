local colors = require("nord.named_colors")

-- Statusline
local nord = {}

nord.normal = {
	a = { fg = colors.dark_gray, bg = colors.glacier },
	b = { fg = colors.darker_white, bg = nil },
	c = { fg = colors.nord4_gui, bg = nil },
}

nord.insert = {
	a = { fg = colors.dark_gray, bg = colors.darker_white },
	b = { fg = colors.white, bg = nil },
	c = {  fg = colors.darker_white, bg = nil },
}

nord.visual = {
	a = { fg = colors.black, bg = colors.teal },
	b = { fg = colors.nord4_gui, bg = nil },
	c = {  fg = colors.darker_white, bg = nil },
}

nord.replace = {
	a = { fg = colors.black, bg = colors.red },
	b = { fg = colors.nord4_gui, bg = nil },
	c = {  fg = colors.darker_white, bg = nil },
}

nord.command = {
	a = { fg = colors.black, bg = colors.purple, gui = "bold" },
	b = { fg = colors.nord4_gui, bg = nil },
	c = {  fg = colors.darker_white, bg = nil },
}

nord.inactive = {
	a = { fg = colors.nord4_gui, bg = colors.black, gui = "bold" },
	b = { fg = colors.nord4_gui, bg = nil },
	c = { fg = colors.nord4_gui, bg = nil },
}

local function lsp_client_names()
	local client_names = {}
	for _, client in ipairs(vim.lsp.get_active_clients()) do
		table.insert(client_names, client.name)
	end

  names = table.concat(client_names, ",")
  if names ~= "" then
    names = "[" .. names .. "]"
  end

	return names
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = nord,
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
      tabline = 50,
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
      },
    },
    lualine_c = {
      '%=',
      -- {
      --   'filetype',
      --   colored = false,
      --   icon_only = true,
      --   padding = 0,
      -- },
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
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
    },
    lualine_b = {
    },
    lualine_c = {
      '%=',
      {
        require("etiole.lualine.custom_components.harpoon_buffers"),
        mode = 0,
        icons_enabled = false,
        buffers_color = {
          -- Same values as the general color option can be used here.
          active = { fg = colors.black, bg = colors.teal },     -- Color for active buffer.
          inactive = { fg = colors.light_gray_bright, bg = "none" }, -- Color for inactive buffer.
        },
        symbols = {
          modified = '*',      -- Text to show when the buffer is modified
          alternate_file = '', -- Text to show to identify the alternate file
          directory =  '',     -- Text to show when the buffer is a directory
        },
        color = {bg='none'}
      },
    },
    lualine_x = {
      {
        'lsp_progress',
        display_components = {'spinner', {}},
        color = {fg = colors.white},
        separators = {
          component = '',
          progress = '',
        },
        spinner_symbols = require("etiole.spinner").half_spinner_rev(),
        timer = {spinner=50}
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
