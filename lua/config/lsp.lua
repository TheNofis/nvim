local M = {}

local language_modules = {
	"lang.typescript",
	"lang.data",
	"lang.lua",
	"lang.prisma",
	"lang.c_cpp",
}

local function merge_servers()
	local servers = {}
	local enabled = {}

	for _, module_name in ipairs(language_modules) do
		local lang = require(module_name)
		for server_name, server_config in pairs(lang.servers()) do
			servers[server_name] = server_config
		end
		vim.list_extend(enabled, lang.enabled())
	end

	return servers, enabled
end

function M.setup()
	vim.lsp.config("*", {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
	})

	vim.filetype.add({
		extension = {
			dsc = "yaml",
		},
		pattern = {
			["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
			["compose%.ya?ml"] = "yaml.docker-compose",
		},
	})

	local servers, enabled = merge_servers()
	for server_name, server_config in pairs(servers) do
		vim.lsp.config(server_name, server_config)
	end

	vim.lsp.enable(enabled)

	vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
	vim.keymap.set("n", "<leader>lD", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
	vim.keymap.set("n", "<leader>lq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, { desc = "Previous diagnostic" })
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, { desc = "Next diagnostic" })
	vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP info" })
	vim.keymap.set("n", "<leader>lR", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
		callback = function(args)
			local map = function(lhs, rhs, desc, opts)
				vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", { buffer = args.buf, desc = desc }, opts or {}))
			end
			local map_both = function(lhs, rhs, desc)
				vim.keymap.set({ "n", "x" }, lhs, rhs, { buffer = args.buf, desc = desc })
			end
			local map_implementation_with_fallback = function()
				local clients = vim.lsp.get_clients({ bufnr = args.buf })
				local supports_implementation = false

				for _, client in ipairs(clients) do
					if client:supports_method("textDocument/implementation") then
						supports_implementation = true
						break
					end
				end

				if supports_implementation then
					vim.lsp.buf.implementation()
					return
				end

				vim.lsp.buf.definition()
			end

			map("gd", vim.lsp.buf.definition, "LSP definition")
			-- nowait: don't pause for the built-in grn/gra/grr/gri maps.
			map("gr", vim.lsp.buf.references, "LSP references", { nowait = true })
			map("gD", vim.lsp.buf.declaration, "LSP declaration")
			map("gy", vim.lsp.buf.type_definition, "LSP type definition")
			map("gi", map_implementation_with_fallback, "LSP implementation (fallback to definition)")
			map("K", vim.lsp.buf.hover, "LSP hover")
			map("<leader>lm", vim.lsp.buf.implementation, "LSP implementation")
			map("<leader>lr", vim.lsp.buf.rename, "LSP rename")
			map("<leader>lf", function()
				require("conform").format({ lsp_fallback = true, timeout_ms = 1000 })
			end, "Format buffer")
			map("<leader>lk", vim.lsp.buf.signature_help, "LSP signature help")
			map("<leader>ls", vim.lsp.buf.document_symbol, "LSP document symbols")
			map("<leader>lS", vim.lsp.buf.workspace_symbol, "LSP workspace symbols")
			map("<leader>lw", vim.lsp.buf.add_workspace_folder, "LSP add workspace folder")
			map("<leader>lW", vim.lsp.buf.remove_workspace_folder, "LSP remove workspace folder")
			map("<leader>ll", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "LSP list workspace folders")
			map("<leader>lh", function()
				local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
				vim.lsp.inlay_hint.enable(not enabled, { bufnr = args.buf })
			end, "LSP toggle inlay hints")
			map_both("<leader>la", vim.lsp.buf.code_action, "LSP code action")
		end,
	})
end

return M
