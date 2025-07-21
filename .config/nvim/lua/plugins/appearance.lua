return {
    {
        "evanasse/chalet",
        dependencies = { "rktjmp/lush.nvim" },
    },
    "arkav/lualine-lsp-progress",
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({
                color_icons = false,
            })
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
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
                    view_search = "cmdline",
                },
                popupmenu = {
                    backend = "nui",
                    keymap = {
                        focus_next = { "<C-j>", "j", "<Down>" },
                        focus_prev = { "<C-k>", "k", "<Up>" },
                        close = { "<Esc>", "<C-c>" },
                        submit = { "<CR>", "<Space>" },
                    }
                },
                notify = {
                    enabled = false,
                },
                hover = {
                    enabled = false
                },
                redirect = {
                    view = "messages"
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
                    },
                    cmdline_popup = {
                        position = {
                            row = 5,
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = "auto",
                        },
                    },
                    popupmenu = {
                        relative = "editor",
                        position = {
                            row = 8,
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = 10,
                        },
                        border = {
                            padding = { 0, 1 },
                        },
                        win_options = {
                            winhighlight = { Normal = "Normal", FloatBorder = "Pmenu" },
                        },
                    },
                },
            })
        end
    }
}
