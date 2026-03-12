local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Общие capabilities для всех LSP
vim.lsp.config("*", {
	capabilities = capabilities,
})

-- Кастомный filetype для *.dsc
vim.filetype.add({
	extension = {
		dsc = "yaml",
	},
})

vim.lsp.config("cssls", {
	filetypes = { "css", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

vim.lsp.config("html", {
	filetypes = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

vim.lsp.config("emmet_language_server", {
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

vim.lsp.config("ts_ls", {
	-- Эквивалент старого lspconfig.util.find_git_ancestor
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { ".git" })
		if root then
			on_dir(root)
		end
	end,
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
		},
	},
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
	end,
})

-- prismals и clangd можно просто включить без override'ов
vim.lsp.enable({
	"cssls",
	"html",
	"emmet_language_server",
	"ts_ls",
	"prismals",
	"clangd",
})

vim.keymap.set("n", "<leader>lD", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	callback = function(args)
		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
		end

		map("gD", vim.lsp.buf.declaration, "LSP declaration")
		map("K", vim.lsp.buf.hover, "LSP hover")
		map("gi", vim.lsp.buf.implementation, "LSP implementation")
		map("<C-k>", vim.lsp.buf.signature_help, "LSP signature help")
	end,
})
