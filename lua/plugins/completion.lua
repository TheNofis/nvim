return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("config.cmp").setup()
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
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
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
	},
}
