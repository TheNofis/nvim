local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup language servers.
local lspconfig = require("lspconfig")

lspconfig.cssls.setup({
	filetypes = { "css", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
})
lspconfig.html.setup({
	filetypes = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
})
lspconfig.emmet_language_server.setup({
	filetypes = {
		"css",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"typescriptreact",
	},
	init_options = {
		showSuggestionsAsSnippets = true,
	},
})
lspconfig.ts_ls.setup({
	capabilities = capabilities,
	root_dir = lspconfig.util.find_git_ancestor,
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
		},
	},
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
	end,
})
lspconfig.prismals.setup({})
lspconfig.cssls.setup({
	capabilities = capabilities,
})

vim.keymap.set("n", "<leader>lD", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	end,
})
