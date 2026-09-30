return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = { "L3MON4D3/LuaSnip" },
		opts = {
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
			snippets = { preset = "luasnip" },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			completion = {
				menu = { border = "rounded" },
				documentation = { auto_show = true, window = { border = "rounded" } },
			},
			signature = { enabled = true, window = { border = "rounded" } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		config = function()
			require("config.luasnip").setup()
		end,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"xabikos/vscode-react",
		},
	},
	{
		"Exafunction/windsurf.nvim",
		event = "InsertEnter",
		config = function()
			require("config.codeium").setup()
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
