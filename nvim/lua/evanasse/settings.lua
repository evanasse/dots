local opt = vim.opt

-- Disable mouse
opt.mouse = ""

-- Show (partial) command in status line.
opt.showcmd = true
-- Show matching brackets.
opt.showmatch = true

-- Do case insensitive matching
opt.ignorecase = true
-- Do smart case matching
opt.smartcase = true
-- Incremental search
opt.incsearch = true

-- Hide buffers when they are abandoned
opt.hidden = true

-- Search down into subfolders
opt.path = opt.path + { "**" }
-- Display all matching files when we tab complete
opt.wildmenu = true

-- Create undofile
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.swapfile = false
opt.backup = false

-- Show line numbers
opt.number = true
-- Show relative line numbers
opt.relativenumber = true

-- Replace tabs with 4 spaces
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- Indenting
opt.smartindent = true

-- Tab completion in two steps (1. list, 2. select)
opt.wildmode = "list:longest,full"

-- Horizontal split will be below
opt.splitbelow = true
-- Vertical split will be on the right
opt.splitright = true

-- File encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Gutter space
vim.opt.signcolumn = 'yes'
