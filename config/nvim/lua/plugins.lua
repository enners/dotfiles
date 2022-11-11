return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	-- editor
	use 'tpope/vim-sensible'  -- common sensible defaults
	use {'junegunn/fzf.vim', requires = {'junegunn/fzf'}}
	use 'morhetz/gruvbox'     -- color scheme
	use 'airblade/vim-rooter' -- workdir to git-root
	use 'tpope/vim-fugitive' -- git
	use 'tpope/vim-surround'  -- {y,c,d}s<FROM><TO>

	-- language support
	use 'neovim/nvim-lspconfig' -- easen lang server cfg
	use {'hrsh7th/nvim-cmp', requires = { -- omnifunc impl
		'hrsh7th/cmp-nvim-lsp', 
		'hrsh7th/cmp-buffer', 
		'hrsh7th/cmp-path', 
		'hrsh7th/cmp-vsnip', 
		'hrsh7th/vim-vsnip',
	}}
	use {'mfussenegger/nvim-dap', requires = { -- debugging
        {'rcarriga/nvim-dap-ui'},
        {'nvim-treesitter/nvim-treesitter',{run = ':TSUpdate'}}, 
		{'nvim-telescope/telescope.nvim'},
		{'nvim-telescope/telescope-dap.nvim'},
		{'nvim-lua/popup.nvim'}, 
		{'nvim-lua/plenary.nvim'},
	}} 
	use 'sbdchd/neoformat'      -- common autoformat interface
	use {'vim-test/vim-test', requires = {'tpope/vim-dispatch'}}
	--use {'theHamsta/nvim-dap-virtual-text', requires = {
--		{'nvim-treesitter/nvim-treesitter',{run = ':TSUpdate'}}, 
--		{'mfussenegger/nvim-dap'}
--	}}
	-- syntax
	use {'fatih/vim-go', requires = {
		'leoluz/nvim-dap-go',
	}}
	use 'mfussenegger/nvim-jdtls'
	use 'udalov/kotlin-vim'
	use {'plasticboy/vim-markdown', requires = { 'godlygeek/tabular' }}
	use 'rust-lang/rust.vim'
	use 'cespare/vim-toml'
	use 'stephpy/vim-yaml'
end)

