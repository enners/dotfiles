--
-- settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0

vim.opt.autowrite = true
vim.opt.background = "dark"
vim.opt.backupdir = "/tmp"
vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.cmdheight = 2
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.diffopt:append("algorithm:histogram")
vim.opt.diffopt:append("indent-heuristic")
vim.opt.diffopt:append("iwhite")
vim.opt.diffopt:append("vertical")
vim.opt.foldenable = false
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 3
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.updatetime = 300
vim.opt.wildmode = "list:longest"
vim.opt.wrap = false

-- Unsure if I need this
vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.timeoutlen = 300
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.hlsearch = true

vim.cmd.colorscheme("lunaperche")
vim.cmd.highlight("Normal ctermbg=none guibg=none")
vim.cmd.highlight("NonText ctermbg=none guibg=none")
vim.cmd.highlight("NormalFloat ctermbg=none guibg=none")
--vim.cmd.highlight("MatchParen ctermbg=darkgreen guibg=darkgreen cterm=bold")

--
-- key bindings
vim.keymap.set("n", "<leader>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader><leader>", "<c-^>") -- toggle between buffers
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
--vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- center cursor after search
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", "*zz", { silent = true })
vim.keymap.set("n", "#", "#zz", { silent = true })
vim.keymap.set("n", "g*", "g*zz", { silent = true })

--
-- autocommands
-- See `:help lua-guide-autocommands`
vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*", command = "set norelativenumber" })
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "set relativenumber" })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Briefly highlight yanked text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
})

local email = vim.api.nvim_create_augroup("email", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "/tmp/mutt*",
	group = email,
	command = "setfiletype mail",
})
vim.api.nvim_create_autocmd("Filetype", { -- text snippets in mutt
	pattern = "mail",
	group = email,
	callback = function()
		local snippet =
			"fzf#run({'options': '--reverse --prompt \"snippets\"', 'down': 20, 'dir': '~/Vorlagen/mail', 'sink': 'r' })"
		vim.keymap.set("n", "<leader>rv", "<cmd>call " .. snippet .. "<cr>")
	end,
})

local ntxt = vim.api.nvim_create_augroup("narrowtext", { clear = true })
for _, ft in ipairs({ "mail", "gitcommit" }) do
	vim.api.nvim_create_autocmd("Filetype", {
		pattern = ft,
		group = ntxt,
		command = "setlocal formatoptions+=w tw=72 colorcolumn=73 spell",
	})
end
local wtxt = vim.api.nvim_create_augroup("widetext", { clear = true })
for _, ft in ipairs({ "java", "rust", "typescript" }) do
	vim.api.nvim_create_autocmd("Filetype", {
		pattern = ft,
		group = wtxt,
		command = "setlocal ts=2 sw=2 tw=100 colorcolumn=101",
	})
end

--
-- `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--
-- plugins :Lazy
require("lazy").setup({
	{ "tpope/vim-fugitive" }, -- git support
	{ "slugbyte/lackluster.nvim", opts = { transparent = true } },

	{
		"vim-test/vim-test",
		dependencies = { "tpope/vim-dispatch" },
		init = function()
			vim.keymap.set("n", "<leader>tt", "<cmd>TestNearest<cr>")
			vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>")
			vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>")
		end,
	},

	{ -- rust
		"rust-lang/rust.vim",
		config = function()
			vim.g.rustfmt_autosave = 1
			vim.g.rustfmt_emit_files = 1
			vim.g.rustfmt_fail_silently = 0
			vim.g.rust_clip_command = "wl-copy"
		end,
	},

	{ -- sql
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			vim.g.db_ui_execute_on_save = 0
			vim.g.db_ui_use_nerd_fonts = 1
			vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<cr>")
		end,
	},

	{ -- small helpers
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })
			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()
		end,
	},

	{ -- fuzzy finder
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			local telescope = require("telescope.builtin")
			vim.keymap.set("n", "<leader>,", telescope.buffers)
			vim.keymap.set("n", "<leader>fb", telescope.git_bcommits)
			vim.keymap.set("n", "<leader>fd", telescope.diagnostics)
			vim.keymap.set("n", "<leader>ff", telescope.find_files)
			vim.keymap.set("n", "<leader>fg", telescope.git_files)
			vim.keymap.set("n", "<leader>fh", telescope.help_tags)
			vim.keymap.set("n", "<leader>fk", telescope.lsp_document_symbols)
			vim.keymap.set("n", "<leader>fm", telescope.keymaps)
			vim.keymap.set("n", "<leader>fs", telescope.live_grep)
		end,
	},

	{ -- autoformat
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>=",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "format buffer",
			},
		},
		opts = {
			async = true,
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 5000,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				java = { "google-java-format" },
				javascript = { { "prettierd", "prettier" } },
			},
		},
	},

	{ -- omnifunc++
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({ -- read :h ins-completion
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	},

	{ -- language support
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			{ "folke/neodev.nvim", opts = {} },
			{ "mfussenegger/nvim-jdtls" },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					local telescope = require("telescope.builtin")
					map("<C-K>", vim.lsp.buf.signature_help, "signature help")
					map("<leader>D", telescope.lsp_type_definitions, "Type [D]efinition")
					map("<leader>a", vim.lsp.buf.code_action, "code [A]ction")
					map("<leader>rw", vim.lsp.buf.rename, "[R]ename [W]ord")
					map("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("gI", telescope.lsp_implementations, "[G]oto [I]mplementation")
					map("gd", telescope.lsp_definitions, "[G]oto [D]efinition")
					map("gr", telescope.lsp_references, "[G]oto [R]eferences")
				end,
			})
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Java needs special treatment
			local java_mappings = function(bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end
				local opts = { noremap = true, silent = true }
				buf_set_keymap("v", "<leader>rev", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
				buf_set_keymap("v", "<leader>rem", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
				buf_set_keymap("n", "<leader>rev", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
				buf_set_keymap("n", "<leader>rec", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
			end
			local java_on_attach = function(_, bufnr)
				require("jdtls").setup_dap()
				require("jdtls.setup")
				require("jdtls.dap").setup_dap_main_class_configs()
				java_mappings(bufnr)
			end
			local java_code_format = vim.fn.stdpath("config") .. "/eclipse-java-google-style.xml"
			local java_bundles = {
				vim.fn.glob(
					vim.fn.stdpath("data")
						.. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
					true
				),
			}
			vim.list_extend(
				java_bundles,
				vim.split(
					vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", true),
					"\n"
				)
			)

			local servers = {
				gopls = {},
				jdtls = {
					-- doc: https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
					settings = {
						java = {
							configuration = {
								runtimes = {
									{ name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk/" },
								},
							},
							format = {
								settings = {
									url = java_code_format,
									profile = "GoogleStyle",
								},
							},
						},
					},
					capabilities = capabilities,
					on_attach = java_on_attach,
					flags = {
						server_side_fuzzy_completion = true,
					},
					init_options = {
						bundles = java_bundles,
					},
				},
				kotlin_language_server = {},
				lua_ls = {},
				pyright = {},
				pylsp = {},
				rust_analyzer = { cmd = { "/sbin/rust-analyzer" } },
				ts_ls = {},
			}

			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
				"yamlls",
				"jdtls",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		opts = {
			auto_install = true,
			autotag = { enable = true },
			ensure_installed = {
				"bash",
				"css",
				"dockerfile",
				"go",
				"html",
				"java",
				"javascript",
				"json",
				"kotlin",
				"lua",
				"markdown",
				"python",
				"rust",
				"sql",
				"typescript",
				"vim",
				"yaml",
			},
			highlight = { enable = true },
			indent = { enable = true, disable = { "ruby" } },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = { query = "@class.outer", desc = "Next class start" },
						["]a"] = "@parameter.inner",
						["]b"] = "@block.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
						["[a"] = "@parameter.inner",
						["[b"] = "@block.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
						["[A"] = "@parameter.outer",
						["[B"] = "@block.outer",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.install").prefer_git = true
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{ -- debug
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("mason-nvim-dap").setup({
				automatic_installation = true,
				automatic_setup = true,
				handlers = {},
				ensure_installed = {
					"delve",
				},
			})
			vim.keymap.set("n", "<leader>dc", dap.continue)
			vim.keymap.set("n", "<leader>dj", dap.step_into)
			vim.keymap.set("n", "<leader>dk", dap.step_out)
			vim.keymap.set("n", "<leader>dl", dap.step_over)
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>db", function()
				dap.set_breakpoint(vim.fn.input("breakpoint condition: "))
			end)
			vim.keymap.set("n", "<leader>dd", dap.run_last)
			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<F7>", dap.step_into)
			vim.keymap.set("n", "<F8>", dap.step_over)
			vim.keymap.set("n", "<F12>", dap.step_out)
			-- Dap UI setup: see |:help nvim-dap-ui|
			--dapui.setup({})
			vim.keymap.set("n", "du", dapui.toggle)
			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
			require("dap-go").setup()
		end,
	},
}, {})
