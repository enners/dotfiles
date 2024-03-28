local ok, neotree = pcall(require, "neo-tree")

if not ok then
	return
end

neotree.setup {
	close_if_last_window = true,
	popup_border_style = "rounded",
	enable_git_status = true,
	name = {
		trailing_slash = false,
		use_git_status_colors = true
	},
	buffers = {
		follow_current_file = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		show_unloaded = true,
		window = {
			mappings = {
				["bd"] = "buffer_delete",
				["h"] = "navigate_up",
				["."] = "set_root"
			}
		}
	},
	filesystem = {
		filtered_items = {
			visible = false, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = true,
			hide_gitignored = true,
		},
		follow_current_file = true, -- This will find and focus the file in the active buffer every
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
		-- instead of relying on nvim autocmd events.
		window = {
			mappings = {
				["h"] = "navigate_up",
				["l"] = "open",
				["."] = "set_root",
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["f"] = "filter_on_submit",
				["<c-x>"] = "clear_filter",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified"
			}
		}
	},
	git_status = {
		window = {
			position = "float",
			mappings = {
				["A"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push"
			}
		}
	}
}
