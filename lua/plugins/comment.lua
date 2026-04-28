local function is_probably_jsx_line(row)
	local line = vim.fn.getline(row)
	return line:find("<[^>]*>") or line:find("</") or line:find("/>%s*$")
end

local function resolve_commentstring(ref_position)
	if vim.bo.filetype == "typescriptreact" then
		local row = type(ref_position) == "table" and ref_position[1] or vim.fn.line(".")
		if is_probably_jsx_line(row) then
			return "{/* %s */}"
		end
	end

	local location = nil
	if type(ref_position) == "table" and ref_position[1] and ref_position[2] then
		local line_nr = ref_position[1]
		local line = vim.fn.getline(line_nr)
		local first_non_blank = vim.fn.match(line, "\\S")
		if type(first_non_blank) ~= "number" or first_non_blank < 0 then
			first_non_blank = ref_position[2] - 1
		end
		location = { line_nr - 1, first_non_blank }
	end

	local ok, cs = pcall(require("ts_context_commentstring.internal").calculate_commentstring, {
		location = location,
	})

	if ok and type(cs) == "string" and cs ~= "" then
		if vim.bo.filetype == "typescriptreact" and cs == "// %s" then
			local row = type(ref_position) == "table" and ref_position[1] or vim.fn.line(".")
			if is_probably_jsx_line(row) then
				return "{/* %s */}"
			end
		end
		return cs
	end

	return vim.bo.commentstring
end

local ts_languages = require("ts_context_commentstring.config").get_languages_config()
local tsx_comment_config = ts_languages.tsx or ts_languages.javascript

require("ts_context_commentstring").setup({
	enable_autocmd = false,
	languages = {
		ecma = tsx_comment_config,
		jsx = tsx_comment_config,
	},
})

require("mini.comment").setup({
	mappings = {
		comment = "<leader>/",
		comment_line = "<leader>/",
		comment_visual = "<leader>/",
		textobject = "gc",
	},
	options = {
		custom_commentstring = resolve_commentstring,
	},
})
