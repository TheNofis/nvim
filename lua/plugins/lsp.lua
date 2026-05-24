return {
	{
		"mason-org/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.lsp").setup()
		end,
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			handler_opts = { border = "rounded" },
		},
	},
}
