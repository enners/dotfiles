local _treesitter, treesitter = pcall(require, "nvim-treesitter.configs")

if not _treesitter then
	return
end

treesitter.setup {
	autotag = {
		enable = true,
	},
	indent = {
		enable = false,
	},
	ensure_installed = { "java", "rust", "python", "go", "lua", "html", "json", "sql", "dockerfile", "yaml", "css",
		"javascript", "typescript" },
	highlight = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@parameter.outer",
				["if"] = "@parameter.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["am"] = "@function.outer",
				["im"] = "@function.inner",
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
				[']a'] = '@parameter.outer',
				[']b'] = '@block.outer',
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
				['[a'] = '@parameter.outer',
				['[b'] = '@block.outer'
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
				['[A'] = '@parameter.outer',
				['[B'] = '@block.outer'
			},
		}
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = 'o',
			toggle_hl_groups = 'i',
			toggle_injected_languages = 't',
			toggle_anonymous_nodes = 'a',
			toggle_language_display = 'I',
			focus_language = 'f',
			unfocus_language = 'F',
			update = 'R',
			goto_node = '<cr>',
			show_help = '?',
		},
	}
}
