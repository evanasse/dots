local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local harpoon_utils = require("harpoon.utils")

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
            for b = 1, vim.fn.bufnr("$") do
                local valid_buf_id, buf_name = pcall(vim.api.nvim_buf_get_name, b)

                if valid_buf_id and buf_name ~= "" then
                    local norm_buf_name = harpoon_utils.normalize_path(buf_name)

                    local f = io.open(norm_buf_name, "r")

                    if f ~= nil then
                        local is_dir = not f:read(0) and f:seek("end") ~= 0
                        f:close()

                        if not is_dir and norm_buf_name ~= "." then
                            if mark.get_length() < 4 then
                                mark.add_file(norm_buf_name)
                            end
                        end
                    end
                end
            end
        end
    }
)
vim.api.nvim_create_autocmd(
    { "VimLeave" },
    {
        group = augroup,
        pattern = { "*" },
        callback = function()
            mark.clear_all()
        end
    }
)
