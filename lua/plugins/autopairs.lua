local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
	check_ts = true,
	enable_check_bracket_line = false,
})

npairs.remove_rule('"')

npairs.add_rule(Rule('"', '"'):with_pair(function(opts)
	local prev_char = opts.line:sub(opts.col - 1, opts.col - 1)
	local next_char = opts.line:sub(opts.col, opts.col)
	return prev_char ~= '"' and next_char ~= '"'
end))
