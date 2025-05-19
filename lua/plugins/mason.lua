local mason = require("mason")
local lspconfig = require("lspconfig")
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

-- Используем имена пакетов Mason для установки
local mason_lsp_packages = {
	"html-lsp",
	"lua-language-server",
	"typescript-language-server",
	"css-variables-language-server",
	"rust-analyzer",
	"prisma-language-server",
	"clangd",
}

-- Соответствующие имена для lspconfig
local lsp_servers = {
	"html",
	"lua_ls",
	"ts_ls",
	"css_variables",
	"rust_analyzer",
	"prismals",
	"clangd",
}

local formatter = {
	"stylua",
	"prettierd",
}

-- Установка LSP и форматтеров через Mason
for _, name in ipairs(vim.list_extend(vim.deepcopy(mason_lsp_packages), formatter)) do
	local ok, pkg = pcall(registry.get_package, name)
	if ok and not pkg:is_installed() then
		pkg:install()
	end
end

-- Настройка LSP через lspconfig
for _, name in ipairs(lsp_servers) do
	local ok, config = pcall(function()
		return lspconfig[name]
	end)

	if ok and config then
		config.setup({})
	else
		vim.notify("LSP config not found for " .. name, vim.log.levels.WARN)
	end
end
