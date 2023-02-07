require('mason.settings').set({
  ui = {
    border = 'rounded'
  }
})

local lsp = require("lsp-zero")

lsp.preset("lsp-compe")

local augroup = "lsp_custom_augroup"
vim.api.nvim_create_augroup(augroup, { clear = true })

vim.api.nvim_create_autocmd("CursorHold", { command = "lua vim.diagnostic.open_float()" })
vim.api.nvim_create_autocmd("BufWritePre", { command = "lua vim.lsp.buf.format({async = false})" })

-- Set updatetime for CursorHold
-- 1000ms of no cursor movement to trigger CursorHold
vim.opt.updatetime = 1000

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rf", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.nvim_workspace()

lsp.set_preferences({
  sign_icons = {
    error = " ",
    warn = " ",
    hint = " ",
    info = " "
  }
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
