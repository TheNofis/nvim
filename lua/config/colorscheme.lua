local M = {}

function M.setup()
	require("everforest").setup({})
	vim.cmd.colorscheme("everforest")
end

return M
