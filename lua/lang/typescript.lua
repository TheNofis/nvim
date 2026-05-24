local M = {}

local function project_root(bufnr, on_dir)
	local root = vim.fs.root(bufnr, {
		"tsconfig.json",
		"jsconfig.json",
		"package.json",
		".git",
	})

	on_dir(root or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)))
end

function M.servers()
	return {
		cssls = {
			filetypes = { "css", "scss", "less" },
		},
		html = {
			filetypes = { "html", "templ" },
		},
		emmet_language_server = {
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
		},
		ts_ls = {
			root_dir = project_root,
			init_options = {
				preferences = {
					importModuleSpecifierPreference = "non-relative",
				},
			},
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
			end,
		},
		eslint = {
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
			end,
		},
		tailwindcss = {
			filetypes = {
				"css",
				"scss",
				"sass",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"html",
			},
		},
	}
end

function M.enabled()
	return { "cssls", "html", "emmet_language_server", "ts_ls", "eslint", "tailwindcss" }
end

return M
