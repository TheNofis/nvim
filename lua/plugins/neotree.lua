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
			hide_gitignored = true,
		},
		follow_current_file = {
			enabled = true,
			leave_dirs_open = true,
		},
		group_empty_dirs = false,
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
	},
})
