local M = {}

function M.opts()
	return {
		notifier = { enabled = true, timeout = 1000, style = "compact" },
		scroll = { enabled = true },
		indent = { enabled = true, animate = { enabled = false } },
		bigfile = { enabled = true },
		words = { enabled = true },
		lazygit = { enabled = true },
		terminal = {
			win = {
				position = "float",
				border = "rounded",
				keys = { term_normal = { "<esc>", "<C-\\><C-n>", mode = "t", expr = false, desc = "Normal mode" } },
			},
		},
	}
end

function M.keys()
	return {
		{ "<F7>", function() Snacks.terminal.toggle() end, mode = { "n", "t" }, desc = "Toggle terminal" },
		{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
		{ "<leader>x", function() Snacks.bufdelete() end, desc = "Close current buffer" },
		{ "<leader>fn", function() Snacks.notifier.show_history() end, desc = "Notification history" },
		{ "]]", function() Snacks.words.jump(1) end, desc = "Next reference" },
		{ "[[", function() Snacks.words.jump(-1) end, desc = "Previous reference" },
	}
end

return M
