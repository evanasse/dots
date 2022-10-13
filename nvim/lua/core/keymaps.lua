local map = function(mode, shortcut, command, options)
    local opts = { noremap = true, silent = true }

    if options then
        for k, v in pairs(options) do
            opts[k] = v
        end
    end

    vim.api.nvim_set_keymap(mode, shortcut, command, opts)
end

function Nmap(shortcut, command, options)
    map('n', shortcut, command, options)
end

function Imap(shortcut, command, options)
    map('i', shortcut, command, options)
end

-- Set 'space' as the leader key
vim.g.mapleader = " "

-- Reload Neovim configuration
Nmap("<leader>vr", "<cmd>source $HOME/.config/nvim/init.lua<cr>")

-- Disable highlight search
Nmap("<leader>h", "<cmd>nohlsearch<cr>")

-- Close Vim window
Nmap("<leader>q", "<cmd>x<cr>")
Nmap("<leader>Q", "<cmd>xa<cr>")

-- Close Vim buffer
Nmap("<leader>p", "<cmd>bd<cr>")

-- Copy until the end of the line
Nmap("Y", "y$")
