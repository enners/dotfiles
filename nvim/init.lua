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
vim.opt.path = "**"
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.wildmode = "list:longest"
vim.opt.winborder = "single"
vim.opt.wrap = false

vim.cmd.highlight("Normal ctermbg=none guibg=none")
vim.cmd.highlight("NonText ctermbg=none guibg=none")
vim.cmd.highlight("NormalFloat ctermbg=none guibg=none")
vim.cmd.highlight("ColorColumn ctermbg=NONE guibg=NvimDarkGray3")
--
-- key bindings
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader><leader>", "<c-^>") -- toggle between buffers
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>qq", vim.diagnostic.setqflist)
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y') -- copy to sys clipboard
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("i", "<C-a>", "<Home>", { silent = true }) -- readline style edit
vim.keymap.set("i", "<C-e>", "<End>", { silent = true })
vim.keymap.set("i", "<C-w>", "<C-o>db", { silent = true })
vim.keymap.set("x", "<leader>p", '"_dP') -- paste preserving clipboard content

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
for _, ft in ipairs({ "java", "kotlin", "python", "rust", "typescript" }) do
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

	{
		"j-hui/fidget.nvim",
		opts = {}, -- progress bottom right corner
	},

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

	{ -- test support
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"rouge8/neotest-rust",
		},
		keys = {
			{
				"<leader>ut",
				function()
					require("neotest").run.run()
				end,
				mode = "n",
			},
			{
				"<leader>ud",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				mode = "n",
			},
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-rust")({}),
					require("neotest-java")({}),
				},
			})
		end,
	},
	{
		"rcasia/neotest-java",
		ft = "java",
		dependencies = {
			"mfussenegger/nvim-jdtls",
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
	},

	{ -- java
		"mfussenegger/nvim-jdtls",
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
	--[[
--]]
	-- autoformat
	--[[
	{ 
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
				json = { "jq" },
				javascript = { "prettierd", "prettier" },
				python = { "ruff" },
			},
		},
	},
	--]]

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
					["<CR>"] = cmp.mapping.confirm({ select = false }),
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
	--[[{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	]]

	{ -- language support
		"neovim/nvim-lspconfig",
		config = function()
			-- see :h lsp-defaults and lsp-config
			-- vim.lsp.config("*", {})
			-- see https://rust-analyzer.github.io/book/configuration.html
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							features = "all",
						},
						check = {
							command = "clippy",
						},
						checkOnSave = {
							enable = true,
						},
						imports = {
							group = {
								enable = false,
							},
						},
					},
				},
			})
			vim.lsp.config("jdtls", {
				init_options = {
					jvm_args = { "-javaagent:/usr/lib/lombok-common/lombok.jar" },
				},
				settings = {
					java = {
						configuration = {
							runtimes = {
								{ name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk/" },
								{ name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk/", default = true },
							},
						},
					},
				},
			})
			vim.lsp.enable({
				"gopls",
				"jdtls",
				"lua_ls",
				"pylsp",
				"ruff", -- python linter
				"rust_analyzer",
				"ts_ls",
			})
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set('n', '<leader>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)
				end,
			})
		end,

	},

	--[[
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
						["\]\]"] = { query = "@class.outer", desc = "Next class start" },
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
		--]]

	--[[
	{ -- debug
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			dap.adapters.lldb = {
				type = "executable",
				command = "/usr/bin/lldb-dap",
				name = "lldb",
			}
			dap.adapters.codelldb = {
				type = "executable",
				command = "codelldb",
				name = "codelldb",
			}
			dap.configurations.rust = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					initCommands = function()
						local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))
						assert(
							vim.v.shell_error == 0,
							"failed to get rust sysroot using `rustc --print sysroot`: " .. rustc_sysroot
						)
						local script_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_lookup.py"
						local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"
						return {
							(\[[!command script import '%s'\]\]):format(script_file),
							([[command source '%s']\]):format(commands_file),
						}
					end,
				},
			}
			local dapui = require("dapui")
			vim.keymap.set("n", "<leader>dc", dap.continue)
			vim.keymap.set("n", "<leader>dj", dap.step_into)
			vim.keymap.set("n", "<leader>dk", dap.step_out)
			vim.keymap.set("n", "<leader>dl", dap.step_over)
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("breakpoint condition: "))
			end)
			vim.keymap.set("n", "<leader>dd", dap.run_last)
			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<F7>", dap.step_into)
			vim.keymap.set("n", "<F8>", dap.step_over)
			vim.keymap.set("n", "<F12>", dap.step_out)
			-- Dap UI setup: see |:help nvim-dap-ui|
			dapui.setup({})
			vim.keymap.set("n", "du", dapui.toggle)
			vim.keymap.set({ "v", "n" }, "de", dapui.eval)
			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
			require("dap-go").setup()
		end,
	},
	--]]
}, {})
