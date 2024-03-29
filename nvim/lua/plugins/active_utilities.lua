return {
    {
        "kylechui/nvim-surround",
        config = true,
    },
    {
        "numToStr/Comment.nvim",
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
        config = true,
    },
    {
        "m4xshen/autoclose.nvim",
        opts = {
            options = {
                disable_when_touch = true
            },
            keys = {
                ["'"] = { close = false },
            }
        }
    },
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        tag = "0.1.2",
        dependencies = { "nvim-lua/plenary.nvim" },
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
                            ["<A-j>"] = "move_selection_next",
                            ["<A-k>"] = "move_selection_previous"
                        }
                    },
                    -- `hidden = true` is not supported in text grep commands.
                    vimgrep_arguments = vimgrep_arguments,
                    color_devicons = false,
                    layout_strategy = "vertical",
                    layout_config = {
                        width = 0.8
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
                            preview_width = 0.6
                        },
                        git_status = false,
                        hidden = { file_browser = true, folder_browser = true },
                    },
                }
            })
            telescope.load_extension("file_browser")
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        lazy = false,
    }
}
