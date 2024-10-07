require("bufferline").setup({
	options = {
		color_icons = true,
		buffer_close_icon = "✘",
		mode = "buffers",

		offsets = {
			{
				filetype = "neo-tree",
				text = "Nvim Tree",
				highlight = "",
			},
		},
		indicator = {
			icon = "▋",
			style = "icon",
		},

		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return "(" .. count .. ")"
		end,
	},
})
