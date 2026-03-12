local mason = require("mason")
local registry = require("mason-registry")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Mason packages (имена mason)
local mason_packages = {
	"html-lsp",
	"lua-language-server",
	"typescript-language-server",
	"emmet-language-server",
	"prisma-language-server",
	"stylua",
	"prettierd",
}

-- Установка через mason
for _, name in ipairs(mason_packages) do
	local ok, pkg = pcall(registry.get_package, name)

	if ok and not pkg:is_installed() then
		pkg:install()
	end
end

-- LSP конфигурации
vim.lsp.config("html", {})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.config("ts_ls", {})

vim.lsp.config("prismals", {})

-- Включение серверов
vim.lsp.enable({
	"html",
	"lua_ls",
	"ts_ls",
	"prismals",
})
