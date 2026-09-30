return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
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
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		opts = {},
		keys = {
			{ "<leader>fR", "<cmd>GrugFar<cr>", desc = "Search & replace (project)" },
			{
				"<leader>fR",
				function()
					require("grug-far").with_visual_selection()
				end,
				mode = "x",
				desc = "Search & replace selection",
			},
		},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
		keys = {
			{ "<leader>qs", function() require("persistence").load() end, desc = "Restore session (cwd)" },
			{ "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
			{ "<leader>qS", function() require("persistence").select() end, desc = "Select session" },
			{ "<leader>qd", function() require("persistence").stop() end, desc = "Don't save this session" },
		},
	},
	{
		"vuki656/package-info.nvim",
		event = "BufRead package.json",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	},
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
