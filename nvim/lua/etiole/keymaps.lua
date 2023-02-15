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

-- Set 'space' as the leader key
vim.g.mapleader = " "
Nmap("<space>", "<nop>")
Vmap("<space>", "<nop>")

-- Disable highlight search
Nmap("<leader>h", "<cmd>set invhlsearch<cr>")

-- Close Vim window (and save if modified)
Nmap("<leader>q", "<cmd>x<cr>")
Nmap("<leader>Q", "<cmd>xa<cr>")

-- Close Vim buffer
Nmap("<leader>p", "<cmd>bd<cr>")

-- Make backspace move back a word instead of a single char
Nmap("<backspace>", "b")

-- Center line of next search
Nmap("n", "nzzzv")
Nmap("N", "Nzzzv")

-- Center cursor when half-page scrolling
Nmap("<c-d>", "<c-d>zz")
Nmap("<c-u>", "<c-u>zz")
-- Center cursor when travelling the jumplist
Nmap("<c-o>", "<c-o>zz")
Nmap("<c-i>", "<c-i>zz")

-- Don't overwrite register when pasting on selected text
Xmap("<leader>p", [["_dP]])

-- Yank to OS clipboard
Nmap("<leader>y", [["+y]])
Vmap("<leader>y", [["+y]])
Nmap("<leader>Y", [["+Y]])

-- Redo
Nmap("<s-u>", "<c-r>")
