require("etiole.globals")
require("etiole.settings")
require("etiole.keymaps")

local augroup = vim.api.nvim_create_augroup
local EtioleGroup = augroup('EtioleGroup', {})

local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufWritePre" }, {
    group = EtioleGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
autocmd({ "BufRead,BufNewFile" }, {
    group = EtioleGroup,
    pattern = "*.nu",
    command = "set filetype=nu",
})
