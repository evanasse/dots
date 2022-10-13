vim.g.nord_disable_background = true
vim.g.nord_italic = false

require('nord').set()

require("appearance.nord.statusline")
require("appearance.nord.highlight_groups")

vim.opt.termguicolors = true

vim.cmd("colorscheme nord")
