return {
    {
        "echasnovski/mini.surround",
        config = true,
    },
    {
        "echasnovski/mini.files",
        version = "*",
        config = true,
    },
    {
        "evanasse/antonyms.nvim",
        dependencies = { "tpope/vim-repeat" },
        config = function()
            require("antonyms").setup()
        end
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("harpoon").setup({
                menu = {
                    width = math.floor(vim.api.nvim_win_get_width(0) - vim.api.nvim_win_get_width(0) * 0.5),
                },
                global_settings = {
                    tabline = true
                }
            })
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        tag = "0.1.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        keys = {
            { "<leader><leader>f", "<cmd>Telescope find_files<cr>" },
            { "<leader><leader>g", "<cmd>Telescope live_grep<cr>" },
            { "<leader><leader>h", "<cmd>Telescope help_tags<cr>" },
            { "<leader><leader>b", "<cmd>Telescope buffers<cr>" },
        },
        init = function()
            local telescope = require("telescope")
            local telescopeConfig = require("telescope.config")
            local actions = require("telescope.actions")

            -- Clone the default Telescope configuration
            local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

            -- I want to search in hidden/dot files.
            table.insert(vimgrep_arguments, "--hidden")
            -- I don't want to search in the `.git` directory.
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!.git/*")

            telescope.setup({
                defaults = {
                    border = false,
                    mappings = {
                        i = {
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                        }
                    },
                    -- `hidden = true` is not supported in text grep commands.
                    vimgrep_arguments = vimgrep_arguments,
                    color_devicons = true,
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.7,
                        mirror = true,
                        preview_width = 0.6
                    },
                },
                pickers = {
                    find_files = {
                        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                        find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
                    },
                },
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                        layout_strategy = "horizontal",
                        layout_config = {
                        },
                        git_status = false,
                        hidden = { file_browser = true, folder_browser = true },
                    },
                }
            })
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        lazy = false,
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                autochdir = true,      -- when neovim changes it current directory the terminal will change it's own when next it's opened
                direction = "float",
                close_on_exit = false, -- close the terminal window when the process exits
                auto_scroll = true,    -- automatically scroll to the bottom on terminal output
                -- This field is only relevant if direction is set to 'float'
                float_opts = {
                    border = "curved",
                    title_pos = "center"
                },
            })
        end
    },
    {
        'milanglacier/minuet-ai.nvim',
        enabled = true,
        config = function()
            require('minuet').setup {
                blink = {
                    enable_auto_complete = true,
                },
                provider = 'openai_fim_compatible',
                n_completions = 1, -- recommend for local model for resource saving
                -- I recommend beginning with a small context window size and incrementally
                -- expanding it, depending on your local computing power. A context window
                -- of 512, serves as an good starting point to estimate your computing
                -- power. Once you have a reliable estimate of your local computing power,
                -- you should adjust the context window to a larger value.
                context_window = 1024,
                provider_options = {
                    openai_fim_compatible = {
                        api_key = 'TERM', -- Using the value of the TERM env var because it needs a value to work
                        name = 'mlx_lm',
                        end_point = 'http://localhost:8123/v1/completions',
                        model = 'mlx-community/Qwen2.5-Coder-1.5B-8bit',
                        optional = {
                            stop = { "<|im_end|>", "\n\n" },
                            max_tokens = 256,
                            top_p = 0.9,
                        },
                    },
                },
                after_cursor_filter_length = 15,
                -- If completion item has multiple lines, create another completion item
                -- only containing its first line. This option only has impact for cmp and
                -- blink. For virtualtext, no single line entry will be added.
                add_single_line_entry = false,
            }
        end,
    },
    {
        "tpope/vim-fugitive",
        lazy = false,
    }
}
