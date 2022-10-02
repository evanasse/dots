local augroup = "telescope_custom_augroup"

vim.api.nvim_create_augroup(augroup, { clear = true })

vim.api.nvim_create_autocmd(
    { "VimEnter" },
    { 
      group = augroup,
      pattern = { "*" },
      command = "hi! link TelescopePreviewBorder TelescopeResultsBorder",
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    { 
      group = augroup,
      pattern = { "*" },
      command = "hi! link TelescopePromptBorder TelescopeResultsBorder",
    }
)
