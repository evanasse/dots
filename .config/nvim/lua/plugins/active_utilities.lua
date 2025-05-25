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
        "huggingface/llm.nvim",
        enabled = false,
        opts = {
            model = "starcoder2:3b",
            backend = "ollama",
            url = "http://localhost:11434", -- llm-ls uses "/api/generate"
            -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters

            request_body = {
                -- Modelfile options for the model you use
                options = {
                    num_predict = 64,
                    temperature = 0.2,
                    top_p = 0.95,
                }
            },
            tokens_to_clear = { "<|endoftext|>" },
            fim = {
                enabled = true,
                prefix = "<fim_prefix>",
                middle = "<fim_middle>",
                suffix = "<fim_suffix>",
            },
            context_window = 512,
            tokenizer = {
                repository = "bigcode/starcoder2-3b",
            },
            lsp = {
                bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
            },
            enable_suggestions_on_startup = true,
            enable_suggestions_on_files = { "*.lua", ".zshrc", "*.nix", "*.gleam" },
            debounce_ms = 400,
            accept_keymap = "<a-.>",
            dismiss_keymap = "<a-,>",
        }
    },
    {
        'milanglacier/minuet-ai.nvim',
        enabled = true,
        config = function()
            require('minuet').setup {
                -- blink = {
                --     enable_auto_complete = true,
                -- },
                provider = 'openai_fim_compatible',
                n_completions = 1, -- recommend for local model for resource saving
                -- I recommend beginning with a small context window size and incrementally
                -- expanding it, depending on your local computing power. A context window
                -- of 512, serves as an good starting point to estimate your computing
                -- power. Once you have a reliable estimate of your local computing power,
                -- you should adjust the context window to a larger value.
                context_window = 400,
                provider_options = {
                    openai_fim_compatible = {
                        api_key = 'TERM',
                        name = 'Ollama',
                        end_point = 'http://localhost:11434/v1/completions',
                        model = 'qwen2.5-coder:3b',
                        optional = {
                            max_tokens = 100,
                            top_p = 0.9,
                        },
                    },
                },
                -- Your configuration options here
                virtualtext = {
                    auto_trigger_ft = { "lua" },
                    keymap = {
                        -- accept whole completion
                        accept = '<A-l>',
                        -- accept one line
                        accept_line = '<A-L>',
                        -- accept n lines (prompts for number)
                        -- e.g. "A-z 2 CR" will accept 2 lines
                        accept_n_lines = '<A-z>',
                        -- Cycle to prev completion item, or manually invoke completion
                        prev = '<A-k>',
                        -- Cycle to next completion item, or manually invoke completion
                        next = '<A-j>',
                        dismiss = '<A-h>',
                    },
                },
            }
        end,
    },
    {
        "tpope/vim-fugitive",
        lazy = false,
    }
}
