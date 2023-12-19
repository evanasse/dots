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

vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({ { import = "plugins" }, { import = "plugins/lsp" } }, {
    ui = {
        border = "rounded"
    }
})
require("evanasse")

vim.cmd("autocmd BufWinEnter,WinEnter term://* startinsert")
vim.cmd("autocmd BufLeave term://* stopinsert")

local width = vim.api.nvim_win_get_width(0)
local cmd = string.format(
    "leftabove vnew | vertical resize -%d | setlocal nonumber norelativenumber signcolumn=no laststatus=3 | call termopen(&shell)",
    width * 0.1
)
vim.cmd(cmd)

local function on_start()
    vim.cmd("wincmd w")
    if vim.api.nvim_buf_get_name(0) == "" then
        require("telescope").extensions.file_browser.file_browser({ git_status = false })
    end
end

if vim.v.vim_did_enter == 1 then
    on_start()
else
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = on_start
    })
end
