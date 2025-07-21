vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
    root_markers = { ".git" }
})

vim.api.nvim_create_autocmd("CursorHold", { command = "lua vim.diagnostic.open_float()" })
-- Set updatetime for CursorHold
-- 1000ms of no cursor movement to trigger CursorHold
vim.opt.updatetime = 1000

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<Down>", function()
            vim.diagnostic.goto_next()
            vim.cmd("normal! zz")
        end, opts)
        vim.keymap.set("n", "<Up>", function()
            vim.diagnostic.goto_prev()
            vim.cmd("normal! zz")
        end, opts)
        vim.keymap.set("n", "<leader>df", function()
            vim.lsp.buf.definition()
            vim.cmd("normal! zz")
        end, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rf", "<cmd>Telescope lsp_references<cr>", opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>dg", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)
        vim.keymap.set({ "i", "n" }, "<C-k>", vim.lsp.buf.signature_help, opts)

        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end
})

vim.diagnostic.config({
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "󰦤",
            [vim.diagnostic.severity.INFO] = "",
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
        }
    }
})

vim.lsp.enable({ "lua-ls", "nix-nil" })
