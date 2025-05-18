vim.cmd([[let g:neo_tree_remove_legacy_commands = 1]])
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

require("neo-tree").setup({
	window = {
		position = "left",
		width = 30,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
	},
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
		group_empty_dirs = false,
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
	},
	git_status = {
		window = {
			position = "left",
			width = 30,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["A"] = "git_add_all",
				["u"] = "git_unstage_file",
				["a"] = "git_add_file",
				["r"] = "git_revert_file",
				["c"] = "git_commit",
				["p"] = "git_push",
				["g"] = "git_commit_and_push",
				["o"] = {
					"show_help",
					nowait = false,
					config = { title = "Order by", prefix_key = "o" },
				},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			},
		},
		symbols = {
			added = " ", -- or "✚", but this is redundant info if you use git_status_colors on the name
			modified = " ", -- or "", but this is redundant info if you use git_status_colors on the name
			deleted = "✖", -- this can only be used in the git_status source
			renamed = "󰁕", -- this can only be used in the git_status source
			untracked = "",
			ignored = "",
			unstaged = "☒",
			staged = "",
			conflict = "",
		},
	},
	source_selector = {
		statusline = true,
		sources = {
			{ source = "filesystem", display_name = " 󰉓 File" },
			{ source = "git_status", display_name = " 󰊢 Git" },
		},
		content_layout = "center",
	},
	enable_git_status = true,
	close_if_last_window = false,
})
