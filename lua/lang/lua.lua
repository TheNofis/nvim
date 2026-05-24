local M = {}

function M.servers()
	return {
		lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		},
	}
end

function M.enabled()
	return { "lua_ls" }
end

return M
