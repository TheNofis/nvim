return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
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
		-- mason first so its bin dir is on PATH before servers start.
		dependencies = { "mason-org/mason.nvim", "saghen/blink.cmp", "b0o/SchemaStore.nvim" },
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		opts = {},
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
		keys = {
			{ "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (project)" },
			{ "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
			{ "<leader>tr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP refs/defs" },
			{ "<leader>tt", "<cmd>Trouble todo toggle<cr>", desc = "TODO list" },
			{ "<leader>tq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
		},
	},
}
