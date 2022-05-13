-- first install packer.nvim
-- git clone https://github./wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
--

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	-- editor
	use 'tpope/vim-sensible'  -- common sensible defaults
	use {'junegunn/fzf.vim', requires = {'junegunn/fzf'}}
	use 'morhetz/gruvbox'     -- color scheme
	use 'airblade/vim-rooter' -- workdir to git-root
	use {'tpope/vim-rhubarb', requires = {'tpope/vim-fugitive'}} -- git
	use 'tpope/vim-surround'  -- {y,c,d}s<FROM><TO>
	-- language support
	use 'neovim/nvim-lspconfig' -- easen lang server cfg
	use 'hrsh7th/nvim-compe'	-- auto completion
	use 'sbdchd/neoformat'      -- common autoformat interface
	use {'vim-test/vim-test', requires = {'tpope/vim-dispatch'}}
	use {'theHamsta/nvim-dap-virtual-text', requires = {{'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}}, {'mfussenegger/nvim-dap'}}}
	-- use 'puremourning/vimspector'
	-- syntax
	use 'fatih/vim-go'
	-- use 'mfussenegger/nvim-jdtls'
	use 'udalov/kotlin-vim'
	use {'plasticboy/vim-markdown', requires = { 'godlygeek/tabular' }}
	use 'rust-lang/rust.vim'
	use 'cespare/vim-toml'
	use 'stephpy/vim-yaml'
end)

