local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local harpoon = require("harpoon")
local log = require("harpoon.dev").log

vim.keymap.set("n", "<leader>M", mark.add_file)
vim.keymap.set("n", "<leader>m", ui.toggle_quick_menu)

vim.keymap.set("n", "<M-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<M-j>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<M-k>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<M-l>", function() ui.nav_file(4) end)

local augroup = "etiole_harpoon"
vim.api.nvim_create_augroup(augroup, { clear = true })

vim.api.nvim_create_autocmd(
    { "BufReadPre" },
    {
        group = augroup,
        pattern = { "*" },
        callback = function()
            if mark.get_length() < 4 then
                mark.add_file()
            end
        end
    }
)
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    {
        group = augroup,
        pattern = { "*" },
        callback = function()
            if mark.get_length() < 4 then
                mark.add_file()
            end
        end
    }
)
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    {
        group = augroup,
        pattern = { "*" },
        callback = function()
            mark.clear_all()
        end
    }
)
