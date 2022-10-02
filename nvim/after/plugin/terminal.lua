function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<a-Space>', "<cmd>ToggleTerm<cr>")
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

Nmap("<a-Space>", "<cmd>ToggleTerm<cr>")
require("toggleterm").setup{
  direction = "float",
}
