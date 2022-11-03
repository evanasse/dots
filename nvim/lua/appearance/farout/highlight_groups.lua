local function set_highlight_command(hl_group, fg_string)
  return string.format("hi! %s guifg='%s'", hl_group, fg_string)
end

local augroup = "custom_hl_augroup"

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
-- ==============
--  Line numbers
-- ==============
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "LineNr", tostring(colors.dark_red))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "LineNrAbove", tostring(colors.dark_green))
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

-- ===========
--  Selection
-- ===========
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg='%s'", "Search", tostring(colors.dark_black), tostring(colors.dark_green))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg='%s'", "IncSearch", tostring(colors.dark_black), tostring(colors.dark_yellow))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg='%s'", "Visual", tostring(colors.dark_black), tostring(colors.dark_red))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg='%s'", "CursorLine", tostring(colors.dark_black), tostring(colors.blue))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg='%s'", "TelescopeSelection", tostring(colors.dark_black), tostring(colors.dark_magenta))
    }
)
-- ============
--  Completion
-- ============
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "CmpItemAbbrDefault", tostring(colors.dark_white))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "CmpItemAbbrDeprecatedDefault", tostring(colors.red))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "CmpItemAbbrMatchDefault", tostring(colors.dark_red))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "CmpItemAbbrMatchFuzzyDefault", tostring(colors.dark_red))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "CmpItemKindDefault", tostring(colors.magenta))
    }
)
-- ============
--    Syntax
-- ============
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "Type", tostring(colors.green))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "DiagnosticError", tostring(colors.red))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "DiagnosticWarn", tostring(colors.yellow))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "DiagnosticInfo", tostring(colors.cyan))
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
      group = augroup,
      pattern = { "*" },
      command = string.format("hi! %s guifg='%s' guibg=NONE", "DiagnosticInfo", tostring(colors.dark_white))
    }
)
