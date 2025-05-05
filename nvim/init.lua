--
-- settings
vim.g.mapleader = " "
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
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.list = true
vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 3
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.wildmode = "list:longest"
vim.opt.wrap = false

vim.cmd.colorscheme("lunaperche")
vim.cmd.highlight("Normal ctermbg=none guibg=none")
vim.cmd.highlight("NonText ctermbg=none guibg=none")
vim.cmd.highlight("NormalFloat ctermbg=none guibg=none")
--vim.cmd.highlight("MatchParen ctermbg=darkgreen guibg=darkgreen cterm=bold")

--
-- key bindings
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader><leader>", "<c-^>") -- toggle between buffers
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("i", "<C-a>", "<Home>", { silent = true }) -- readline style edit
vim.keymap.set("i", "<C-e>", "<End>", { silent = true })
vim.keymap.set("i", "<C-w>", "<C-o>db", { silent = true })
--
-- autocommands
-- See `:help lua-guide-autocommands`
vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*", command = "set norelativenumber" })
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "set relativenumber" })

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		for _, c in ipairs({ "n", "N", "*", "#", "g*" }) do
			vim.keymap.set("n", c, c .. "zz", { silent = true })
		end
	end,
	desc = "center cursor after move operations",
	group = vim.api.nvim_create_augroup("center-cursor", { clear = true }),
})

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
	--[[
	{ -- the new completer
		"saghen/blink.nvim",
	    dependencies = { 'rafamadriz/friendly-snippets' },
		version = "1.*",
		lazy = false,
	},
	]]

	{ -- language support
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "folke/neodev.nvim", opts = {} },
			{ "mfussenegger/nvim-jdtls" },
		},
		config = function()
			vim.lsp.config("*", {})
			-- java
			local java_on_attach = function(_, bufnr)
				require("jdtls").setup_dap()
				require("jdtls.setup")
				require("jdtls.dap").setup_dap_main_class_configs()
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
			local java_project = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local java_ws = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. java_project
			vim.lsp.config("jdtls", {
				on_attach = java_on_attach,
				flags = {
					server_side_fuzzy_completion = true,
				},
				init_options = {
					bundles = java_bundles,
				},
				settings = {
					java = {
						configuration = {
							runtimes = {
								{ name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk/" },
								{ name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk/" },
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
			})
			vim.lsp.enable({
				"gopls",
				"jdtls",
				"kotlin_language_server",
				"lua_ls",
				"pyright",
				"pylsp",
				"rust_analyzer",
				"ts_ls",
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
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
						["[a"] = "@parameter.inner",
						["[b"] = "@block.outer",
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
