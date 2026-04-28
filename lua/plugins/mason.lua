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
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- Включение только lua_ls здесь.
-- Остальные LSP (html/css/ts/prisma/...) подключаются централизованно в lua/plugins/lsp.lua.
vim.lsp.enable({ "lua_ls" })
