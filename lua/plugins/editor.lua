return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ "<F7>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
		},
		config = function()
			require("config.toggleterm").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		event = "BufReadPre",
		config = function()
			require("mini.indentscope").setup({ symbol = "│", draw = { delay = 0 } })
		end,
	},
	{
		"echasnovski/mini.move",
		event = "BufReadPre",
		config = function()
			require("mini.move").setup({
				mappings = { left = "<A-left>", right = "<A-right>", down = "<A-down>", up = "<A-up>" },
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		event = "BufReadPre",
		config = function()
			require("mini.surround").setup({ mappings = { add = "S", delete = "D" } })
		end,
	},
	{
		"nvim-mini/mini.comment",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.comment").setup()
		end,
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	},
	{ "folke/which-key.nvim", event = "VeryLazy" },
	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"gbprod/yanky.nvim",
		event = "BufReadPost",
		config = function()
			require("yanky").setup()
		end,
	},
	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1,
		config = function()
			require("langmapper").setup({})
		end,
	},
}
