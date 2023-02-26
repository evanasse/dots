return {
    "ethanholz/nvim-lastplace",
    "airblade/vim-rooter",
    "RRethy/vim-illuminate",
    "lukas-reineke/indent-blankline.nvim",
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                },
            })
        end
    },
}
