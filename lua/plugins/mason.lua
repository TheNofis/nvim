require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- LSP
require("mason-lspconfig").setup({
	ensure_installed = {
		"denols",
		"lua_ls",
		"ts_ls",
		"cssls",
		"clangd",
	},
})

-- FORMATTER
require("mason-null-ls").setup({
	ensure_installed = {
		"css-variables-language-server",
		"eslint_d",
		"stylua",
		"prettierd",
		"fustfmt",
	},
})
