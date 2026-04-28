local function is_probably_jsx_line(row)
	local line = vim.fn.getline(row)
	if type(line) ~= "string" or line == "" then
		return false
	end

	return line:find("<[^>]*>") ~= nil or line:find("</") ~= nil or line:find("/>%s*$") ~= nil
end

local function in_jsx_context(location)
	local ok, parser = pcall(vim.treesitter.get_parser, 0)
	if not ok or parser == nil then
		return false
	end

	local row = location[1]
	local col = location[2]
	local range = { row, col, row, col }
	local lang_tree = parser:language_for_range(range)
	if not lang_tree then
		return false
	end

	local root = lang_tree:root()
	if not root then
		return false
	end

	local node = root:named_descendant_for_range(row, col, row, col)
	while node do
		local t = node:type()
		if t == "jsx_element" or t == "jsx_fragment" or t == "jsx_opening_element" or t == "jsx_closing_element" then
			return true
		end
		node = node:parent()
	end

	return false
end

local function resolve_commentstring(ref_position)
	if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "javascriptreact" then
		local row = type(ref_position) == "table" and ref_position[1] or vim.fn.line(".")
		local col = type(ref_position) == "table" and ref_position[2] or vim.fn.col(".")
		if in_jsx_context({ row - 1, math.max(col - 1, 0) }) or is_probably_jsx_line(row) then
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
		if (vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "javascriptreact") and cs == "// %s" then
			local row = type(ref_position) == "table" and ref_position[1] or vim.fn.line(".")
			local col = type(ref_position) == "table" and ref_position[2] or vim.fn.col(".")
			if in_jsx_context({ row - 1, math.max(col - 1, 0) }) or is_probably_jsx_line(row) then
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
		tsx = tsx_comment_config,
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
