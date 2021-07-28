-- first install packer.nvim
-- git clone https://github./wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
--

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	-- editor
	use 'tpope/vim-sensible'  -- common sensible defaults
	use 'godlygeek/tabular'   -- text alignment
	use 'junegunn/fzf.vim'
	use 'morhetz/gruvbox'     -- color scheme
	use {
		'hoob3rt/lualine.nvim',
		requires = {'ryanoasis/vim-devicons', opt = true}
	}
	use 'airblade/vim-rooter' -- workdir to git-root
	use 'tpope/vim-surround'  -- {y,c,d}s<FROM><TO>
	-- language support
	use 'neovim/nvim-lspconfig' -- easen lang server cfg
	use 'hrsh7th/nvim-compe'	-- auto completion
	use 'vim-test/vim-test'
	use 'tpope/vim-dispatch'
	use 'fatih/vim-go'
	use 'rust-lang/rust.vim'
	use 'plasticboy/vim-markdown'
	use 'cespare/vim-toml'
	use 'stephpy/vim-yaml'
end)

