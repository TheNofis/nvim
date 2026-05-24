local M = {}

local language_modules = {
	"lang.typescript",
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
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	vim.lsp.config("*", {
		capabilities = capabilities,
	})

	vim.filetype.add({
		extension = {
			dsc = "yaml",
		},
	})

	local servers, enabled = merge_servers()
	for server_name, server_config in pairs(servers) do
		vim.lsp.config(server_name, server_config)
	end

	vim.lsp.enable(enabled)

	vim.keymap.set("n", "<leader>lD", vim.diagnostic.open_float, { desc = "Line diagnostics" })
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, { desc = "Previous diagnostic" })
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, { desc = "Next diagnostic" })
	vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
		callback = function(args)
			local map = function(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
			end

			map("gD", vim.lsp.buf.declaration, "LSP declaration")
			map("K", vim.lsp.buf.hover, "LSP hover")
			map("gi", vim.lsp.buf.implementation, "LSP implementation")
			map("<leader>k", vim.lsp.buf.signature_help, "LSP signature help")
		end,
	})
end

return M
