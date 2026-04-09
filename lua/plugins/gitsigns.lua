local gs = require("gitsigns")

gs.setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},

	current_line_blame = true, -- inline blame
	current_line_blame_opts = {
		delay = 500,
		virt_text_pos = "eol",
	},

	on_attach = function(bufnr)
		local map = function(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
		end
	end,
})
