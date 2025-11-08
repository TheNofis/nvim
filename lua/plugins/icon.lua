local web_devicons = require("nvim-web-devicons")

local function hl(name)
	local ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = name })
	if ok and hl_def and hl_def.fg then
		return string.format("#%06x", hl_def.fg)
	end
	return "#A0A0A0" -- fallback
end

web_devicons.setup({
	override = {
		-- backend
		["module.ts"] = {
			icon = "󰠱",
			color = hl("Function"),
			name = "NestModule",
		},
		["service.ts"] = {
			icon = "",
			color = hl("Identifier"),
			name = "NestService",
		},
		["controller.ts"] = {
			icon = "",
			color = hl("Type"),
			name = "NestController",
		},
		["guard.ts"] = {
			icon = "󰌾",
			color = hl("Boolean"),
			name = "NestGuard",
		},
		["interceptor.ts"] = {
			icon = "󰕥",
			color = hl("Keyword"),
			name = "NestInterceptor",
		},
		["filter.ts"] = {
			icon = "󰈲",
			color = hl("Conditional"),
			name = "Filter",
		},
		["schema.ts"] = {
			icon = "󰜖",
			color = hl("Type"),
			name = "Schema",
		},
		["decorator.ts"] = {
			icon = "󰌗",
			color = hl("Special"),
			name = "Decorator",
		},
		["dto.ts"] = {
			icon = "",
			color = hl("String"),
			name = "NestDTO",
		},

		-- frontend
		["component.tsx"] = {
			icon = "",
			color = hl("Function"),
			name = "ReactComponent",
		},
		["layout.tsx"] = {
			icon = "󰉼",
			color = hl("Include"),
			name = "Layout",
		},
		["page.tsx"] = {
			icon = "",
			color = hl("Type"),
			name = "Page",
		},
		["hook.ts"] = {
			icon = "󰠱",
			color = hl("Identifier"),
			name = "Hook",
		},
		["api.ts"] = {
			icon = "󰖟",
			color = hl("String"),
			name = "API",
		},
		["store.ts"] = {
			icon = "󰓆",
			color = hl("Constant"),
			name = "Store",
		},
		["types.ts"] = {
			icon = "",
			color = hl("Special"),
			name = "Types",
		},

		-- 💅 Стили
		["styles.ts"] = {
			icon = "",
			color = hl("Identifier"),
			name = "Styles",
		},
		["module.css"] = {
			icon = "",
			color = hl("Identifier"),
			name = "CSSModule",
		},

		-- 📦 Конфиги / Env
		["env"] = {
			icon = "",
			color = hl("PreProc"),
			name = "Env",
		},
		["config.ts"] = {
			icon = "",
			color = hl("PreProc"),
			name = "Config",
		},
	},
})
