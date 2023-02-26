require("etiole.globals")
require("etiole.settings")
require("etiole.keymaps")

vim.g.netrw_banner = 0

local augroup = vim.api.nvim_create_augroup
local EtioleGroup = augroup('EtioleGroup', {})

local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufWritePre" }, {
    group = EtioleGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
