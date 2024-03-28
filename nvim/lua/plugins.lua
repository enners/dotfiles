return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	-- editor
	use 'tpope/vim-sensible' -- common sensible defaults
	use 'tpope/vim-fugitive'
	use { 'junegunn/fzf.vim', requires = { 'junegunn/fzf' } }
	use 'airblade/vim-rooter' -- workdir to git-root

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
	use { 'leoluz/nvim-dap-go' }
	--use {'fatih/vim-go', requires = {
	--	'leoluz/nvim-dap-go',
	--}}
	use { 'mfussenegger/nvim-jdtls' }
	use 'udalov/kotlin-vim'
	use { 'plasticboy/vim-markdown', requires = { 'godlygeek/tabular' } }
	use 'rust-lang/rust.vim'
	use 'stephpy/vim-yaml'
	use 'kristijanhusak/vim-dadbod-completion'
	use	'tpope/vim-dadbod'
	use { 'kristijanhusak/vim-dadbod-ui' , require = {
		{ 'kristijanhusak/vim-packager'},
	}}
end)
