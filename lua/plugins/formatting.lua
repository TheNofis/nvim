return {
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo", "ConformSync" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.conform").setup()
		end,
	},
}
