require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use {
	    'nvim-treesitter/nvim-treesitter',
	    run = ':TSUpdate'
	}
	use 'nvim-treesitter/playground'
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-ui-select.nvim'

	use 'ap/vim-css-color'
	use {
	    'windwp/nvim-autopairs',
	    config = function() require("nvim-autopairs").setup {{ map_cr = true }} end
	}
	use 'morhetz/gruvbox'

	use "williamboman/mason.nvim"
	use 'neovim/nvim-lspconfig'

	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
end)

-- Old Packages 
--
-- use 'jonsmithers/vim-html-template-literals'
-- use 'jiangmiao/auto-pairs'
-- use 'pangloss/vim-javascript'
-- use 'MaxMEllon/vim-jsx-pretty'
-- use 'alvan/vim-closetag'











