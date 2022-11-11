local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local mappings = function(bufnr)
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local opts = { noremap = true, silent = true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rw', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float({scope="line"})<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

local options = function(bufnr)
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
	vim.diagnostic.config({
		virtual_text = false,
		signs = true,
	})
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
	options(bufnr)
	mappings(bufnr)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
	"gopls",
	"kotlin_language_server",
	"sumneko_lua",
	"rust_analyzer",
	"tsserver",
}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		capabilities = capabilities,
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		}
	}
end

-- Java needs special treatment
local java_mappings = function(bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local opts = { noremap = true, silent = true }
	mappings(bufnr)
	buf_set_keymap("v", "<leader>rev", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
	buf_set_keymap("v", "<leader>rem", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
	buf_set_keymap("n", "<leader>rev", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
	buf_set_keymap("n", "<leader>rec", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
end

local java_on_attach = function(_, bufnr)
	require("jdtls").setup_dap({ hotcodereplace = "auto" })
	require('jdtls.setup').add_commands()
	require("jdtls.dap").setup_dap_main_class_configs()
	options(bufnr)
	java_mappings(bufnr)
end

local java_code_format = vim.fn.stdpath('config') .. '/eclipse-java-google-style.xml'
local java_bundles = {
	--  vim.fn.glob(vim.fn.stdpath('data') ..'/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', 1),
	vim.fn.glob("/home/knut/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
		, 1),
};
vim.list_extend(java_bundles,
	vim.split(vim.fn.glob("/home/knut/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", 1), "\n"))

nvim_lsp['jdtls'].setup {
	settings = {
		java = {
			configuration = {
				runtimes = {
					{ name = 'JavaSE-11', path = '/usr/lib/jvm/java-11-openjdk/' },
					{ name = 'JavaSE-17', path = '/usr/lib/jvm/java-17-openjdk/' },
				}
			},
			format = {
				settings = {
					url = java_code_format,
					profile = 'GoogleStyle',
				},
			},
		},
	},
	capabilities = capabilities,
	on_attach = java_on_attach,
	flags = {
		server_side_fuzzy_completion = true
	},
	init_options = { bundles = java_bundles },
	--handlers = {
	-- Due to an invalid protocol implementation in the jdtls we have to conform these to be spec compliant.
	-- https://github.com/eclipse/eclipse.jdt.ls/issues/376
	--	['$/progress'] = function() end,
	--},
}
