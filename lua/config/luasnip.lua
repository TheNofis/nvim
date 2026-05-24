local M = {}

function M.setup()
	local loader = require("luasnip.loaders.from_vscode")

	loader.lazy_load()
	loader.lazy_load({
		paths = { vim.fn.stdpath("data") .. "/lazy/vscode-react/snippets" },
	})
end

return M
