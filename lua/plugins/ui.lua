return {
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
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = function()
			return require("config.snacks").opts()
		end,
		keys = function()
			return require("config.snacks").keys()
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			-- vim.notify is owned by snacks.notifier, signature help by blink.cmp.
			notify = { enabled = false },
			lsp = { signature = { enabled = false } },
		},
	},
	{
		"echasnovski/mini.statusline",
		event = "VeryLazy",
		opts = {},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = "BufReadPost",
		config = function()
			require("config.highlight_colors").setup()
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "BufReadPost",
		init = function()
			-- Parens only in TSX, so tag names keep the component/HTML colors.
			vim.g.rainbow_delimiters = { query = { tsx = "rainbow-parens" } }
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		config = function()
			require("scrollbar").setup()
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
