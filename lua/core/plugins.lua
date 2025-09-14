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
		"phaazon/hop.nvim",
		event = "BufReadPost",
		config = true,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
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

	{ "neovim/nvim-lspconfig", event = "BufReadPre" },
	{ "mason-org/mason.nvim", cmd = "Mason" },
	{ "mason-org/mason-lspconfig.nvim", cmd = "Mason" },
	{ "mason-org/mason-registry", cmd = "Mason" },

	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			handler_opts = { border = "rounded" },
		},
	},

	{ "navarasu/onedark.nvim", lazy = false },

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

	{ "nvim-telescope/telescope.nvim", cmd = "Telescope", dependencies = { "nvim-lua/plenary.nvim" } },

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

	{ "numToStr/Comment.nvim", keys = { "<Leader>/", "<Leader>/" } },

	{
		"willothy/nvim-cokeline",
		event = "BufWinEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
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
		"Exafunction/codeium.nvim",
		name = "codeium",
		event = "InsertEnter",
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
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("typescript-tools").setup({
				settings = {
					tsserver_file_preferences = {
						includeInlayParameterNameHints = "all",
						includeCompletionsForModuleExports = true,
						quotePreference = "auto",
					},
					tsserver_format_options = {
						allowIncompleteCompletions = true,
						allowRenameOfImportPath = true,
					},
				},
			})
		end,
	},
})
