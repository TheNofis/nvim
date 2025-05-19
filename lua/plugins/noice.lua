require("noice").setup({
	routes = {
		{
			filter = {
				event = "msg_show",
				kind = "info",
				find = "written",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "info",
				find = "saved",
			},
			opts = { skip = true },
		},
	},
})
