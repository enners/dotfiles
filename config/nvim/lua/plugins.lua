return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	-- editor
	use 'tpope/vim-sensible' -- common sensible defaults
	use { 'junegunn/fzf.vim', requires = { 'junegunn/fzf' } }
	use 'kvrohit/rasmus.nvim' -- +let g:rasmus_variant = "monochrome"
	use 'sainnhe/gruvbox-material'
	use "EdenEast/nightfox.nvim"

	use 'airblade/vim-rooter' -- workdir to git-root
	use 'tpope/vim-fugitive' -- git
	use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
	--use 'tpope/vim-surround'  -- {y,c,d}s<FROM><TO>
	use('kylechui/nvim-surround')
	use {
		-- Tree file explorer
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
		config = require "neotree"
	}

	-- language support
	use 'neovim/nvim-lspconfig' -- easen lang server cfg
	use {
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground", -- View treesitter information directly in Neovim
		},
		run = ":TSUpdate",
		config = require "treesitter"
	}
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use { 'hrsh7th/nvim-cmp', requires = { -- omnifunc impl
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-vsnip',
		'hrsh7th/vim-vsnip',
	} }
	use { 'mfussenegger/nvim-dap', requires = { -- debugging
		{ 'rcarriga/nvim-dap-ui' },
		{ 'nvim-treesitter/nvim-treesitter' },
		{ 'nvim-telescope/telescope.nvim' },
		{ 'nvim-telescope/telescope-dap.nvim' },
		{ 'nvim-lua/popup.nvim' },
		{ 'nvim-lua/plenary.nvim' },
	} }
	use 'sbdchd/neoformat' -- common autoformat interface
	use { 'vim-test/vim-test', requires = { 'tpope/vim-dispatch' } }
	use { 'theHamsta/nvim-dap-virtual-text', requires = {
		{ 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } },
		{ 'mfussenegger/nvim-dap' },
	} }
	-- syntax
	use { "williamboman/mason.nvim" }
	--use {'fatih/vim-go', requires = {
	--	'leoluz/nvim-dap-go',
	--}}
	use { 'mfussenegger/nvim-jdtls' }
	use 'udalov/kotlin-vim'
	use { 'plasticboy/vim-markdown', requires = { 'godlygeek/tabular' } }
	use 'rust-lang/rust.vim'
	use 'stephpy/vim-yaml'
end)
