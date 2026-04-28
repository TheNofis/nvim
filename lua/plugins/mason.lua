local mason = require("mason")
local registry = require("mason-registry")
local uv = vim.uv or vim.loop

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

-- Установка через mason только при первом запуске
local marker = vim.fn.stdpath("state") .. "/mason_first_install_done"
if not uv.fs_stat(marker) then
	for _, name in ipairs(mason_packages) do
		local ok, pkg = pcall(registry.get_package, name)

		if ok and not pkg:is_installed() then
			pkg:install()
		end
	end

	local fd = uv.fs_open(marker, "w", 420)
	if fd then
		uv.fs_write(fd, tostring(os.time()), -1)
		uv.fs_close(fd)
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
