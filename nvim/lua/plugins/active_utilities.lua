return {
    {
        "echasnovski/mini.surround",
        config = true,
    },
    {
        "echasnovski/mini.comment",
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
        "echasnovski/mini.pairs",
        config = function()
            require("mini.pairs").setup({
                mappings = {
                    ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][%s]' },
                    ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][%s]' },
                    ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][%s]' },

                    [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
                    [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
                    ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

                    ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\][%s]', register = { cr = false } },
                    ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\][%s]', register = { cr = false } },
                    ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\][%s]', register = { cr = false } },
                },
            })
        end,
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
            { "<leader><leader>b",
                "<cmd>lua require('telescope').extensions.file_browser.file_browser({git_status=false})<cr>" }
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
                        }
                    },
                    -- `hidden = true` is not supported in text grep commands.
                    vimgrep_arguments = vimgrep_arguments,
                    color_devicons = false,
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
    }
}
