local M = {}

local mason_packages = {
	"html-lsp",
	"css-lsp",
	"lua-language-server",
	"vtsls",
	"json-lsp",
	"yaml-language-server",
	"dockerfile-language-server",
	"docker-compose-language-service",
	"eslint-lsp",
	"tailwindcss-language-server",
	"emmet-language-server",
	"prisma-language-server",
	"stylua",
	"prettierd",
}

function M.setup()
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

	for _, name in ipairs(mason_packages) do
		local ok, pkg = pcall(registry.get_package, name)
		if ok and not pkg:is_installed() then
			pkg:install()
		end
	end
end

return M
