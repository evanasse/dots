return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local augroup = "lsp_custom_augroup"
        vim.api.nvim_create_augroup(augroup, { clear = true })

        vim.api.nvim_create_autocmd("CursorHold", { command = "lua vim.diagnostic.open_float()" })
        vim.api.nvim_create_autocmd("BufWritePre", { command = "lua vim.lsp.buf.format({async = false})" })

        -- Set updatetime for CursorHold
        -- 1000ms of no cursor movement to trigger CursorHold
        vim.opt.updatetime = 1000

        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap

        local opts = { noremap = true, silent = true }
        local function on_attach(client, bufnr)
            keymap.set("n", "K", vim.lsp.buf.hover, opts)
            keymap.set("n", "<Down>", function()
                vim.diagnostic.goto_next()
                vim.cmd("norm zz")
            end, opts)
            keymap.set("n", "<Up>", function()
                vim.diagnostic.goto_prev()
                vim.cmd("norm zz")
            end, opts)
            keymap.set("n", "<leader>df", function()
                vim.lsp.buf.definition()
                vim.cmd("norm zz")
            end, opts)
            keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            keymap.set("n", "<leader>rf", "<cmd>Telescope lsp_references<cr>", opts)
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            keymap.set("n", "<leader>dg", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)
            keymap.set({ "i", "n" }, "<C-k>", vim.lsp.buf.signature_help, opts)
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()
        local sign_icons = {
            Error = "",
            Warn = "",
            Hint = "󰦤",
            Info = "",
        }

        for type, icon in pairs(sign_icons) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        vim.diagnostic.config({
            virtual_text = true,
            float = { border = "rounded" }
        })

        require("lspconfig.ui.windows").default_options = {
            border = "rounded"
        }

        vim.lsp.handlers["textDocument/hover"] =
            vim.lsp.with(
                vim.lsp.handlers.hover,
                {
                    border = "rounded"
                }
            )

        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(
                vim.lsp.handlers.signature_help,
                {
                    border = "rounded"
                }
            )
        -- LSP configs
        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        }
                    }
                }
            }
        })
        lspconfig["pylsp"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig["taplo"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig["marksman"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig["dockerls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig["bashls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig["gopls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig["rust_analyzer"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig["yamlls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig["julials"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end
}
