local function set_highlight_command(hl_group, fg_string)
  return string.format("hi! %s guifg='%s'", hl_group, fg_string)
end

local function set_highlight_command_virtual_text(hl_group, fg_string)
  return string.format("hi! %s cterm=italic gui=italic guifg='%s'", hl_group, fg_string)
end

local augroup = "custom_hl_augroup"

local colors = require("appearance.named_colors")

vim.api.nvim_create_augroup(augroup, { clear = true })

-- =====
--  LSP
-- =====
-- Diagnostic
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = set_highlight_command("DiagnosticInfo", tostring(colors.dark_white)),
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = set_highlight_command_virtual_text("DiagnosticVirtualTextInfo", tostring(colors.dark_white)),
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = set_highlight_command("DiagnosticError", tostring(colors.red)),
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = set_highlight_command_virtual_text("DiagnosticVirtualTextError", tostring(colors.red)),
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = set_highlight_command("DiagnosticWarn", tostring(colors.yellow)),
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = set_highlight_command_virtual_text("DiagnosticVirtualTextWarn", tostring(colors.yellow)),
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = set_highlight_command("DiagnosticHint", tostring(colors.dark_blue)),
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = set_highlight_command_virtual_text("DiagnosticVirtualTextHint", tostring(colors.dark_blue)),
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = set_highlight_command("DiagnosticOk", tostring(colors.green)),
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = set_highlight_command_virtual_text("DiagnosticVirtualTextOk", tostring(colors.green)),
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi clear %s", "DiagnosticUnderlineInfo", tostring(colors.green)),
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
    command = "hi! link LspInfoBorder FloatBorder",
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
    command = string.format("hi! %s guifg='%s' guibg=NONE", "LineNrAbove", tostring(colors.dark_cyan))
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
    command = string.format("hi! %s guifg='%s' guibg='%s'", "Search", tostring(colors.dark_black),
      tostring(colors.dark_green))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg='%s'", "IncSearch", tostring(colors.dark_black),
      tostring(colors.dark_yellow))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg='%s'", "Visual", tostring(colors.dark_black),
      tostring(colors.dark_red))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s'", "CursorLine", tostring(colors.red))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! link %s %s", "CurSearch", "IncSearch")
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg='%s'", "TelescopeSelection", tostring(colors.dark_black),
      tostring(colors.dark_magenta))
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
    command = string.format("hi! %s guifg='%s' guibg=NONE", "Type", tostring(colors.dark_blue))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg=NONE", "String", tostring(colors.dark_green))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg=NONE", "Character", tostring(colors.green))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg=NONE", "Identifier", tostring(colors.cyan))
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
    command = string.format("hi! %s guifg='%s' guibg=NONE", "DiagnosticInfo", tostring(colors.dark_white))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg=NONE", "@variable", tostring(colors.dark_white))
  }
)

-- =============
--    General
-- =============
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guibg=NONE ctermbg=NONE", "Normal")
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = "hi! link Conceal Comment",
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = "hi! link QuickFixLine CursorLine",
  }
)
-- ===========
--    Mason
-- ===========
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg=NONE", "MasonHighlight", tostring(colors.dark_red))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg='%s' gui=bold", "MasonHighlightBlockBold", tostring(colors.black),
      tostring(colors.red))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg='%s' gui=bold", "MasonHeaderSecondary", tostring(colors.black),
      tostring(colors.red))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg='%s'", "MasonHighlightBlock", tostring(colors.black),
      tostring(colors.red))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg='%s' gui=bold", "MasonHighlightBlockBoldSecondary",
      tostring(colors.black),
      tostring(colors.dark_yellow))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg='%s' gui=bold", "MasonHeader", tostring(colors.black),
      tostring(colors.dark_yellow))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg='%s'", "MasonHighlightBlockSecondary", tostring(colors.black),
      tostring(colors.dark_yellow))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s'", "MasonHighlightSecondary", tostring(colors.dark_yellow))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = "hi! link MasonMuted LineNrAbove",
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg='%s'", "MasonMutedBlock", tostring(colors.black),
      tostring(colors.dark_cyan))
  }
)
vim.api.nvim_create_autocmd(
  { "VimEnter" },
  {
    group = augroup,
    pattern = { "*" },
    command = string.format("hi! %s guifg='%s' guibg='%s' gui=bold", "MasonMutedBlockBold", tostring(colors.black),
      tostring(colors.dark_cyan))
  }
)
