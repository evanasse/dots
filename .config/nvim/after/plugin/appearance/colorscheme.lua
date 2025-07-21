require("appearance")

vim.opt.termguicolors = true
vim.opt.cursorline = true

local colors = require("chalet_colors")

local augroup = "clear_devicondefault"

vim.api.nvim_create_augroup(augroup, { clear = true })
vim.api.nvim_create_autocmd(
	{ "VimEnter" },
	{
		group = augroup,
		pattern = { "*" },
		command = string.format("hi! DevIconDefault guifg=%s", colors.white),
	}
)
