require("evanasse.globals")
require("evanasse.settings")
require("evanasse.keymaps")

local augroup = vim.api.nvim_create_augroup
local EvanasseGroup = augroup("EvanasseGroup", {})

local autocmd = vim.api.nvim_create_autocmd

-- Cleanup trailing whitespace
autocmd({ "BufWritePre" }, {
    group = EvanasseGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
