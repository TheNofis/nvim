local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "phaazon/hop.nvim" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
	},
	{ "neovim/nvim-lspconfig" },
	{ "navarasu/onedark.nvim" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"tailwind-tools",
			"onsails/lspkind-nvim",
		},
		opts = function()
			return {
				formatting = {
					format = require("lspkind").cmp_format({
						before = require("tailwind-tools.cmp").lspkind_format,
					}),
				},
			}
		end,
	},
	{ "hrsh7th/vim-vsnip" },
	{ "hrsh7th/vim-vsnip-integ" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{ "jose-elias-alvarez/null-ls.nvim" },
	{ "windwp/nvim-autopairs" },
	{ "Djancyp/outline" },
	{ "numToStr/Comment.nvim" },
	{ "windwp/nvim-ts-autotag" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"linrongbin16/lsp-progress.nvim",
		},
	},
	{ "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"lukas-reineke/indent-blankline.nvim",
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("plugins.nullls")
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				routes = {
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written", -- Уведомления о сохранении файла
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "notify",
							find = "Error", -- Сообщения об ошибках
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							find = "E21: Cannot make changes", -- Сообщения об ошибках
						},
						opts = { skip = true },
					},
				},
			})
		end,
	},
	{ "folke/which-key.nvim" },

	-- AI AUTO COMPLITE
	{
		"Exafunction/codeium.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				enable_cmp_source = false,
				virtual_text = {
					enabled = true,
					manual = false,
					idle_delay = 0,
					key_bindings = {
						accept = "<Space><Tab>",
					},
				},
			})
		end,
	},

	-- COLORIZE {} () <>
	{ "norcalli/nvim-colorizer.lua" },
	{ "HiPhish/rainbow-delimiters.nvim" },

	-- Renamer + Outline
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				lightbulb = {
					enable = false,
				},
				symbol_in_winbar = {
					enable = false,
				},
				rename = {
					auto_save = true,
					in_select = false,
				},
				outline = {
					layout = "float",
					details = false,
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
			"neovim/nvim-lspconfig", -- optional
		},
		opts = {}, -- your configuration
	},
})
