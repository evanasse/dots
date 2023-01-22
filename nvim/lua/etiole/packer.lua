-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Filetype
    use "elkowar/yuck.vim"

    -- Appearance
    use 'shaunsingh/nord.nvim'
    use 'fcpg/vim-farout'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'xiyaowong/nvim-transparent'
    use 'arkav/lualine-lsp-progress'

    -- Active utilities
    use {
        "evanasse/alterego.nvim",
        requires = { "tpope/vim-repeat" },
    }
    use "numToStr/Comment.nvim"
    use "kylechui/nvim-surround"
    use {
        "ThePrimeagen/harpoon",
        requires = { "nvim-lua/plenary.nvim" }
    }

    -- Passive utilities
    use "ethanholz/nvim-lastplace"
    use "airblade/vim-rooter"
    use "RRethy/vim-illuminate"
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use "lukas-reineke/indent-blankline.nvim"
    use "tpope/vim-sleuth" -- Detect tabstop and shiftwidth automatically

    -- LSP and completion
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = { "nvim-lua/plenary.nvim" }
    }

    if is_bootstrap then
        require('packer').sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this file
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
