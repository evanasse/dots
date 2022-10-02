local augroup = "illuminate_custom_augroup"

vim.api.nvim_create_augroup(augroup, { clear = true })

vim.api.nvim_create_autocmd(
    { "VimEnter" },
    { 
      group = augroup,
      pattern = { "*" },
      command = "hi! link illuminatedWord Search",
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    { 
      group = augroup,
      pattern = { "*" },
      command = "hi! link illuminatedCurWord Search",
    }
)
