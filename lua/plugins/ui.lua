return {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("config.colorscheme").setup()
		end,
	},
	{
		"DaikyXendo/nvim-material-icon",
		lazy = false,
		config = function()
			require("config.icons").setup()
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		config = function()
			require("config.neotree").setup()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"DaikyXendo/nvim-material-icon",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require("config.telescope").setup()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
	},
	{
		"willothy/nvim-cokeline",
		event = "BufWinEnter",
		config = function()
			require("config.buffline").setup()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"DaikyXendo/nvim-material-icon",
		},
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			require("config.notify").setup()
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		config = function()
			require("noice").setup({})
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = "BufReadPost",
		config = function()
			require("config.highlight_colors").setup()
		end,
	},
	{ "HiPhish/rainbow-delimiters.nvim", event = "BufReadPost" },
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		config = function()
			require("scrollbar").setup()
		end,
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("config.neoscroll").setup()
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
