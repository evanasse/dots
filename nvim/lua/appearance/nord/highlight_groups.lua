local function set_highlight_command(hl_group, fg_string)
  return string.format("hi! %s guifg='%s'", hl_group, fg_string)
end

local augroup = "lsp_custom_hl_augroup"

local colors = require("appearance.farout.named_colors")

vim.api.nvim_create_augroup(augroup, { clear = true })

vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = set_highlight_command("LspDiagnosticsDefaultWarning", tostring(colors.yellow)),
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = set_highlight_command("LspDiagnosticsVirtualTextWarning", tostring(colors.yellow)),
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = set_highlight_command("LspDiagnosticsFloatingWarning", tostring(colors.yellow)),
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = set_highlight_command("LspDiagnosticsSignWarning", tostring(colors.yellow)),
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = set_highlight_command("LspDiagnosticsWarning", tostring(colors.yellow)),
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = set_highlight_command("healthWarning", tostring(colors.yellow)),
    }
)

-- Fix floating windows
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "FloatBorder", tostring(colors.white))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "NormalFloat", tostring(colors.white))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = "hi! link CursorLine Search",
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "LineNr", tostring(colors.red))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "LineNrAbove", tostring(colors.blue))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = "hi! link LineNrBelow LineNrAbove"
    }
)
