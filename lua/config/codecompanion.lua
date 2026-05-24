local M = {}

function M.opts()
	return {
		interactions = {
			chat = {
				adapter = "codex",
			},
			cli = {
				agent = "codex",
			},
		},
		adapters = {
			acp = {
				codex = function()
					return require("codecompanion.adapters").extend("codex", {
						commands = {
							default = { "codex-acp" },
						},
						defaults = {
							auth_method = "chatgpt",
						},
					})
				end,
			},
		},
	}
end

return M
