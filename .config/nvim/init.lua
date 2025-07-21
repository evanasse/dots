vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "plugins" }, }, {
    ui = {
        border = "rounded",
    },
    change_detection = {
        notify = false
    }
})

require("evanasse")
require("lsp")

vim.cmd("autocmd BufWinEnter,WinEnter term://* startinsert")

local on_start = require("evanasse.windows").on_nvim_start

if vim.v.vim_did_enter == 1 then
    on_start()
else
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = on_start
    })
end
