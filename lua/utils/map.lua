local M = {}

function M.set(mode, lhs, rhs, desc, opts)
	opts = vim.tbl_extend("force", {
		noremap = true,
		silent = true,
		desc = desc,
	}, opts or {})

	if desc == nil then
		opts.desc = nil
	end

	vim.keymap.set(mode, lhs, rhs, opts)
end

return M
