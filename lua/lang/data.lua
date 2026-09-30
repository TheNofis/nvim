local M = {}

function M.servers()
	local schemastore = require("schemastore")

	return {
		jsonls = {
			settings = {
				json = {
					schemas = schemastore.json.schemas(),
					validate = { enable = true },
				},
			},
		},
		yamlls = {
			settings = {
				yaml = {
					schemaStore = { enable = false, url = "" },
					schemas = schemastore.yaml.schemas(),
				},
			},
		},
	}
end

function M.enabled()
	return { "jsonls", "yamlls", "dockerls", "docker_compose_language_service" }
end

return M
