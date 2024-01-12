local map = function(mode, shortcut, command, options)
    local opts = { noremap = true, silent = true }

    if options then
        for k, v in pairs(options) do
            opts[k] = v
        end
    end

    vim.keymap.set(mode, shortcut, command, opts)
end

function Nmap(shortcut, command, options)
    map('n', shortcut, command, options)
end

function Imap(shortcut, command, options)
    map('i', shortcut, command, options)
end

function Vmap(shortcut, command, options)
    map('v', shortcut, command, options)
end

function Xmap(shortcut, command, options)
    map('x', shortcut, command, options)
end

function Omap(shortcut, command, options)
    map('o', shortcut, command, options)
end

function Tmap(shortcut, command, options)
    map('t', shortcut, command, options)
end

-- Set 'space' as the leader key
vim.g.mapleader = " "
Nmap("<space>", "<nop>")
Vmap("<space>", "<nop>")

-- Disable highlight search
Nmap("<leader>H", "<cmd>set invhlsearch<cr>")

-- Close Vim buffer
Nmap("<leader>q", "<cmd>lua require('harpoon.mark').rm_file(vim.api.nvim_buf_get_name(0))<cr><cmd>bp | bd #<cr>")
-- Exit and close everyting
Nmap("<leader>x", "<cmd>qa<cr>")

-- Make backspace move back a word instead of a single char
Nmap("<backspace>", "b")
Omap("<backspace>", "b")

-- Center line of next search
Nmap("n", "nzzzv")
Nmap("N", "Nzzzv")
-- Center cursor when half-page scrolling
Nmap("<c-d>", "<c-d>zz")
Nmap("<c-u>", "<c-u>zz")
-- Center cursor when travelling the jumplist
Nmap("<c-o>", "<c-o>zz")
Nmap("<c-i>", "<c-i>zz")
-- Center cursor when jumping to end of file
Nmap("G", "Gzz")

-- Don't overwrite register when pasting on selected text
Xmap("<leader>p", [["_dP]])

-- Yank to OS clipboard
Nmap("<leader>y", [["+y]])
Vmap("<leader>y", [["+y]])
Nmap("<leader>Y", [["+Y]])

-- Add semi-colon at the EOL if not present
Nmap("<leader>;", "<cmd>s/;\\?$/;/<cr>$")

-- Add empty line above/below
Nmap("<leader>O", "O<esc>j")
Nmap("<leader>o", "o<esc>k")

-- Move selected text up/down
Vmap("J", ":m '>+1<CR>gv=gv")
Vmap("K", ":m '<-2<CR>gv=gv")

-- Terminal mappings
Nmap("<a-a>", "<c-w><c-w>")
Imap("<a-a>", "<esc><c-w><c-w>")
Tmap("<a-a>", "<c-\\><c-n><c-w><c-w>")
Tmap("<esc>", "<c-\\><c-n>")
