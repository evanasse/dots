return {
    {
        "ethanholz/nvim-lastplace",
        config = true,
    },
    "airblade/vim-rooter",
    "RRethy/vim-illuminate",
    "lukas-reineke/indent-blankline.nvim",
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                },
            })
            require("nvim-treesitter").setup()
        end
    },
    "nvim-treesitter/nvim-treesitter-context",
    {
        "https://github.com/NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                user_default_options = {
                    names = false,
                    css = true,
                    css_fn = false,
                    mode = "virtualtext"
                }
            })
        end
    }
}
