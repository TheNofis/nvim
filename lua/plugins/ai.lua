return {
	{
		"olimorris/codecompanion.nvim",
		event = "VeryLazy",
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCLI" },
		version = "^19.0.0",
		opts = function()
			return require("config.codecompanion").opts()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
