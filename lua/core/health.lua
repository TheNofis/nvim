vim.api.nvim_create_user_command("NvimConfigHealth", function()
	local required = { "git", "rg", "node", "npm", "codex", "codex-acp" }

	for _, bin in ipairs(required) do
		local ok = vim.fn.executable(bin) == 1
		local level = ok and vim.log.levels.INFO or vim.log.levels.WARN
		vim.notify(string.format("%s: %s", bin, ok and "ok" or "missing"), level, { title = "nvim config" })
	end
end, { desc = "Check local tools required by this config" })
