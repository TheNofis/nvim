return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSUpdate", "TSUninstall", "TSInstallInfo" },
		build = ":TSUpdate",
		config = function()
			require("config.treesitter").setup()
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("config.autotag").setup()
		end,
	},
}
