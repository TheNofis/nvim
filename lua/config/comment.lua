local M = {}

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
	local node = nil

	local ok_lang, lang_tree = pcall(parser.language_for_range, parser, range)
	if ok_lang and type(lang_tree) == "table" then
		local ok_root, root = pcall(function()
			if type(lang_tree.root) == "function" then
				return lang_tree:root()
			end
			return nil
		end)

		if ok_root and root and type(root.named_descendant_for_range) == "function" then
			node = root:named_descendant_for_range(row, col, row, col)
		end
	end

	if node == nil and type(vim.treesitter.get_node) == "function" then
		local ok_node, ts_node = pcall(vim.treesitter.get_node, { bufnr = 0, pos = { row, col } })
		if ok_node then
			node = ts_node
		end
	end

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

function M.setup()
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
			comment = "",
			comment_line = "",
			comment_visual = "",
			textobject = "gc",
		},
		options = {
			custom_commentstring = resolve_commentstring,
		},
	})

	vim.keymap.set("n", "<leader>/", function()
		local line = vim.fn.line(".")
		require("mini.comment").toggle_lines(line, line, { ref_position = { line, vim.fn.col(".") } })
	end, { desc = "Toggle comment line", silent = true })

	vim.keymap.set("x", "<leader>/", function()
		local start_line = vim.fn.line("v")
		local end_line = vim.fn.line(".")
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end

		require("mini.comment").toggle_lines(start_line, end_line, {
			ref_position = { start_line, vim.fn.col("v") },
		})
	end, { desc = "Toggle comment selection", silent = true })
end

return M
