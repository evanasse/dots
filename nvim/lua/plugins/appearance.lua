return {
    "fcpg/vim-farout",
    "xiyaowong/nvim-transparent",
    "arkav/lualine-lsp-progress",
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons", opt = true }
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim"
        },
        config = function()
            require("noice").setup({
                messages = {
                    enabled = false,
                    view = "cmdline",
                    view_error = "cmdline",
                    view_warn = "cmdline",
                    view_history = "cmdline",
                    view_search = "virtualtext",
                },
                popupmenu = {
                    backend = "cmp"
                },
                notify = {
                    enabled = false,
                },
                hover = {
                    enabled = false
                },
                redirect = {
                    view = "cmdline"
                },
                lsp = {
                    message = {
                        enabled = false,
                        view = "cmdline"
                    },
                    progress = {
                        enabled = false
                    },
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    hover = {
                        enabled = false
                    },
                    signature = {
                        enabled = false
                    }
                },
                views = {
                    cmdline = {
                        timeout = 2000
                    }
                }
            })
        end
    }
}
