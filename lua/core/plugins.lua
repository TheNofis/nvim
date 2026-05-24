local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"DaikyXendo/nvim-material-icon",
			"MunifTanjim/nui.nvim",
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},

	{ "mason-org/mason.nvim", event = { "BufReadPre", "BufNewFile" } },
	{ "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },

	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			handler_opts = { border = "rounded" },
		},
	},

	-- cmp и сниппеты
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
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
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"xabikos/vscode-react",
				config = function()
					require("luasnip.loaders.from_vscode").load({
						paths = { vim.fn.stdpath("data") .. "/lazy/vscode-react/snippets" },
					})
				end,
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-ui-select.nvim",
		},
	},

	{ "akinsho/toggleterm.nvim", version = "*", cmd = { "ToggleTerm", "TermExec" }, config = true },

	{ "stevearc/conform.nvim", cmd = { "ConformInfo", "ConformSync" } },

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
			require("mini.surround").setup({
				mappings = {
					add = "S",
					delete = "D",
				},
			})
		end,
	},

	{
		"nvim-mini/mini.comment",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("plugins.comment")
		end,
	},

	{
		"willothy/nvim-cokeline",
		event = "BufWinEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"DaikyXendo/nvim-material-icon",
		},
		config = true,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({})
		end,
	},

	{ "folke/which-key.nvim", event = "VeryLazy" },

	-- AI автодополнение
	{
		"Exafunction/windsurf.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
	},

	-- Цветовое выделение
	{ "brenoprata10/nvim-highlight-colors", event = "BufReadPost" },
	{ "HiPhish/rainbow-delimiters.nvim", event = "BufReadPost" },

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
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		config = function()
			require("scrollbar").setup()
		end,
	},

	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
	},

	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({})
		end,
	},

	{
		"kkrampis/codex.nvim",
		lazy = true,
		cmd = { "Codex", "CodexToggle" }, -- Optional: Load only on command execution
	},

	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1,
		config = function()
			require("langmapper").setup({})
		end,
	},
})
