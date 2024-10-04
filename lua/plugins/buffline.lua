require("bufferline").setup({
	options = {
		color_icons = true,
		buffer_close_icon = "✘",
		mode = "buffers",

		offsets = {
			{
				filetype = "neo-tree",
				text = "File Explorer",
				separator = true,
				padding = 0,
			},
		},

		indicator = {
			icon = "▋",
			-- icon = " ✔ ", -- this should be omitted if indicator style is not 'icon'
			style = "icon",
		},
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},

		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return "(" .. count .. ")"
		end,
	},
})
