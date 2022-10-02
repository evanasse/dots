local lspconfig = require('lspconfig')

local augroup = "lsp_custom_augroup"
vim.api.nvim_create_augroup(augroup, { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", { command = "lua vim.lsp.buf.format({async = true})"})

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.opt.signcolumn = "yes"

-- Set updatetime for CursorHold
-- 1000ms of no cursor movement to trigger CursorHold
vim.opt.updatetime = 1000

-- Code navigation shortcuts
Nmap("<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
Nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
Nmap("gD", "<cmd>lua vim.lsp.buf.implementation()<CR>")
Nmap("<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
Nmap("1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
Nmap("grf", "<cmd>lua vim.lsp.buf.references()<CR>")
Nmap("grn", "<cmd>lua vim.lsp.buf.rename()<CR>")
Nmap("g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
Nmap("gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
Nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
Nmap("ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
Nmap("<leader>format", "<cmd> lua vim.lsp.buf.format({async = true})<CR>")

-- Goto previous/next diagnostic warning/error
Nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
Nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")

local util = require('lspconfig.util')
local border
require('rust-tools').setup({
  server = {
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded" }),
    },
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", require("rust-tools").hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "ga", require("rust-tools").code_action_group.code_action_group, { buffer = bufnr })
      -- Show floating diagnostic on cursor hold
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
          }
          vim.diagnostic.open_float(nil, opts)
        end
      })
    end,
    settings = {
      standalone = false,
      ["rust-analyzer"] = {
        checkOnSave = {
          overrideCommand = {
            "cargo",
            "clippy",
            "--workspace", "--message-format=json", "--all-targets",
            "--manifest-path", util.path.join(util.root_pattern("Cargo.toml")(vim.api.nvim_buf_get_name(0)), "Cargo.toml"),
            "--",
            "-W", "clippy::pedantic",
            "-W", "clippy::nursery",
            "-W", "clippy::unwrap_used",
            "-W", "clippy::expect_used",
          }
        },
      }
    }
  },
})

