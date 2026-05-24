local M = {}

function M.setup()
	require("nvim-highlight-colors").setup({
		render = "background",
		virtual_symbol = "",
		virtual_symbol_prefix = " ",
		virtual_symbol_suffix = " ",
		virtual_symbol_position = "eow",
		enable_hex = true,
		enable_short_hex = true,
		enable_rgb = true,
		enable_hsl = true,
		enable_hsl_without_function = true,
		enable_var_usage = true,
		enable_named_colors = true,
		enable_tailwind = true,
		exclude_filetypes = {},
		exclude_buftypes = {},
		exclude_buffer = function(bufnr)
			local name = vim.api.nvim_buf_get_name(bufnr)
			if name == "" then
				return false
			end
			return vim.fn.getfsize(name) > 1000000
		end,
	})
end

return M
