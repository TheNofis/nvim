local M = {}

function M.setup()
	require("toggleterm").setup({
		open_mapping = [[<F7>]],
		direction = "float",
		float_opts = {
			highlights = { border = "Normal", background = "Normal" },
			border = "curved",
		},
		size = 10,
	})

	vim.api.nvim_create_autocmd("TermOpen", {
		group = vim.api.nvim_create_augroup("UserToggleTermKeymaps", { clear = true }),
		pattern = "term://*",
		callback = function()
			local opts = { buffer = true }
			vim.keymap.set("t", "<esc>", [[<C-\\><C-n>]], opts)
			vim.keymap.set("t", "<F7>", [[<Cmd>ToggleTerm<CR>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\\><C-n><C-w>]], opts)
		end,
	})
end

return M
