-- local lspconfig = require('lspconfig')
--
-- local augroup = "lsp_custom_augroup"
-- vim.api.nvim_create_augroup(augroup, { clear = true })
--
-- vim.api.nvim_create_autocmd("BufWritePre", { command = "lua vim.lsp.buf.format({async = true})"})
--
-- -- have a fixed column for the diagnostics to appear in
-- -- this removes the jitter when warnings/errors flow in
-- vim.opt.signcolumn = "yes"
--
-- -- Set updatetime for CursorHold
-- -- 1000ms of no cursor movement to trigger CursorHold
-- vim.opt.updatetime = 1000
--
-- -- Code navigation shortcuts
-- Nmap("<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- Nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
-- Nmap("gD", "<cmd>lua vim.lsp.buf.implementation()<CR>")
-- Nmap("<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
-- Nmap("1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
-- Nmap("grf", "<cmd>lua vim.lsp.buf.references()<CR>")
-- Nmap("grn", "<cmd>lua vim.lsp.buf.rename()<CR>")
-- Nmap("g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
-- Nmap("gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
-- Nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- Nmap("ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
-- Nmap("<leader>format", "<cmd> lua vim.lsp.buf.format({async = true})<CR>")
--
-- -- Goto previous/next diagnostic warning/error
-- Nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
-- Nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")