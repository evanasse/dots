require("evanasse.globals")
require("evanasse.settings")
require("evanasse.keymaps")

local augroup = vim.api.nvim_create_augroup
local EvanasseGroup = augroup("EvanasseGroup", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufWritePre" }, {
    group = EvanasseGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
autocmd({ "BufRead,BufNewFile" }, {
    group = EvanasseGroup,
    pattern = "*.nu",
    command = "set filetype=nu",
})
autocmd({ "VimEnter" }, {
    group = EvanasseGroup,
    pattern = "*",
    callback = function()
        if vim.api.nvim_buf_get_name(0) == "" then
            require("telescope").extensions.file_browser.file_browser({ git_status = false })
        end
    end,
})
