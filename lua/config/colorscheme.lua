local M = {}

-- Built-in default scheme, retinted to the graphite palette shared with st and the Fabric shell.
function M.setup()
	vim.o.background = "dark"
	vim.cmd.colorscheme("default")
	local hl = function(name, opts) vim.api.nvim_set_hl(0, name, opts) end
	local bg, surface, raised, fg, muted, accent = "#1C1C1E", "#232326", "#2C2C2E", "#E5E5EA", "#8E8E93", "#0A84FF"
	-- No background on the editor itself: st's translucent, picom-blurred background shows through.
	hl("Normal", { fg = fg })
	hl("NormalNC", { fg = fg })
	hl("EndOfBuffer", { fg = bg })
	hl("NormalFloat", { fg = fg, bg = surface })
	hl("FloatBorder", { fg = "#3A3A3C", bg = surface })
	hl("SignColumn", {})
	hl("LineNr", { fg = "#636366" })
	hl("CursorLineNr", { fg = fg, bold = true })
	hl("CursorLine", { bg = surface })
	hl("ColorColumn", { bg = surface })
	hl("Visual", { bg = "#1F4570" })
	hl("Search", { fg = "#FFFFFF", bg = "#1F4570" })
	hl("CurSearch", { fg = "#FFFFFF", bg = "#0071E3" })
	hl("IncSearch", { link = "CurSearch" })
	hl("Pmenu", { fg = fg, bg = raised })
	hl("PmenuSel", { fg = "#FFFFFF", bg = "#0071E3" })
	hl("PmenuThumb", { bg = "#48484A" })
	hl("StatusLine", { fg = fg, bg = surface })
	hl("StatusLineNC", { fg = muted })
	hl("WinSeparator", { fg = "#3A3A3C" })
	hl("TabLine", { fg = muted })
	hl("TabLineSel", { fg = "#FFFFFF", bg = "#0071E3" })
	hl("TabLineFill", {})
	hl("Comment", { fg = "#8E8E93", italic = true })
	hl("MatchParen", { fg = accent, bold = true })
	hl("Directory", { fg = "#409CFF" })
	hl("Title", { fg = "#F5F5F7", bold = true })

	-- Syntax: Xcode-dark-style hues, same Apple family as the UI palette above.
	local keyword, str, num, typ, func, prop, punct = "#FF7AB2", "#FF8170", "#D9C97C", "#6BDFFF", "#B281EB", "#78C2B3", "#A1A1A6"
	local groups = {
		[keyword] = { "Statement", "Keyword", "Conditional", "Repeat", "Include", "PreProc", "@keyword", "@keyword.return", "@keyword.import", "@keyword.function", "@keyword.operator", "@tag.builtin" },
		[str] = { "String", "Character", "@string" },
		[num] = { "Number", "Float", "Boolean", "Constant", "@number", "@boolean", "@constant", "@constant.builtin", "@variable.builtin" },
		[typ] = { "Type", "@type", "@type.builtin", "@constructor", "@tag", "@module" },
		[func] = { "Function", "@function", "@function.call", "@function.method", "@function.method.call", "@function.builtin" },
		[prop] = { "@property", "@variable.member", "@tag.attribute" },
		[punct] = { "Delimiter", "@punctuation.bracket", "@punctuation.delimiter", "@tag.delimiter" },
		[fg] = { "Identifier", "Operator", "Special", "@variable", "@variable.parameter", "@operator", "@punctuation.special" },
	}
	for color, names in pairs(groups) do
		for _, name in ipairs(names) do
			hl(name, { fg = color })
		end
	end

	-- Rainbow levels: calm tones only; red reads as an error.
	local rainbow = {
		Red = punct,
		Yellow = "#C9B77A",
		Blue = "#6AA8D8",
		Orange = "#A08BC9",
		Green = "#7FAFA3",
		Violet = "#B08FA8",
		Cyan = "#8FA3B8",
	}
	for name, color in pairs(rainbow) do
		hl("RainbowDelimiter" .. name, { fg = color })
	end
end

return M
