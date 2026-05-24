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

	vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
	vim.keymap.set("n", "<leader>lD", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
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
			local map = function(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
			end
			local map_both = function(lhs, rhs, desc)
				vim.keymap.set({ "n", "x" }, lhs, rhs, { buffer = args.buf, desc = desc })
			end

			map("gd", vim.lsp.buf.definition, "LSP definition")
			map("gr", vim.lsp.buf.references, "LSP references")
			map("gD", vim.lsp.buf.declaration, "LSP declaration")
			map("K", vim.lsp.buf.hover, "LSP hover")
			map("gi", vim.lsp.buf.implementation, "LSP implementation")
			map("<leader>lr", vim.lsp.buf.rename, "LSP rename")
			map("<leader>lf", function()
				require("conform").format({ lsp_fallback = true, timeout_ms = 1000 })
			end, "Format buffer")
			map("<leader>lk", vim.lsp.buf.signature_help, "LSP signature help")
			map_both("<leader>la", vim.lsp.buf.code_action, "LSP code action")
		end,
	})
end

return M
