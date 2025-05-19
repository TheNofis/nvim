require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		typescript = { "prettierd" },
		javascript = { "prettierd" },
		typescriptreact = { "prettierd" },
		javascriptreact = { "prettierd" },
		css = { "prettierd" },
		scss = { "prettierd" },
		less = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		["markdown.mdx"] = { "prettierd" },
		graphql = { "prettierd" },
		handlebars = { "prettierd" },
		c = { "clang_format" },
		cpp = { "clang_format" },
	},

	format_on_save = {
		timeout_ms = 1000,
		lsp_fallback = true,
	},

	notify_on_error = false,
})
