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
    "nvim-treesitter/nvim-treesitter-context"
}
