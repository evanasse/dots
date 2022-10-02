local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Filetype
  use "nathom/filetype.nvim"

  -- Appearance
  use 'shaunsingh/nord.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Active utilities
  use {
    "evanasse/alterego.nvim",
    requires = { "tpope/vim-repeat" },
    config = function()
        require("alterego").setup()
    end
  }
  use "tpope/vim-unimpaired"
  use "tpope/vim-commentary"
  use "jiangmiao/auto-pairs"
  use {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end
  }
  use {
    "akinsho/toggleterm.nvim",
    tag = 'v2.*',
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

  -- LSP and completion
  ---- Collection of common configurations for the Nvim LSP client
  use "neovim/nvim-lspconfig"
  ---- Completion framework
  use "hrsh7th/nvim-cmp"
  ---- LSP completion source for nvim-cmp
  use "hrsh7th/cmp-nvim-lsp"
  ---- Snippet completion source for nvim-cmp
  use "hrsh7th/cmp-vsnip"
  ---- Other useful completion sources
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-buffer"
  ---- Snippet engine
  use "hrsh7th/vim-vsnip"
  ---- Popup
  use "nvim-lua/popup.nvim"
  ---- Progress message
  use 'arkav/lualine-lsp-progress'

  -- Telescope
  use "nvim-lua/plenary.nvim"
  use "nvim-telescope/telescope.nvim"

  -- Rust
  use {
    "rust-lang/rust.vim",
  }
  use {
    "simrat39/rust-tools.nvim",
  }

  -- Fixes
  -- use "antoinemadec/FixCursorHold.nvim"

end)
