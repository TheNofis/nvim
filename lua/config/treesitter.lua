local M = {}

local parsers = {
	"typescript",
	"tsx",
	"javascript",
	"jsdoc",
	"html",
	"css",
	"scss",
	"json",
	"yaml",
	"prisma",
	"bash",
	"markdown",
	"markdown_inline",
	"sql",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"dockerfile",
	"gitignore",
	"go",
}

local select_maps = {
	k = "block",
	c = "class",
	["?"] = "conditional",
	f = "function",
	l = "loop",
	a = "parameter",
}

local move_maps = {
	k = "@block.outer",
	c = "@class.outer",
	f = "@function.outer",
	a = "@parameter.outer",
}

local swap_maps = {
	k = "@block.outer",
	f = "@function.outer",
	a = "@parameter.inner",
}

local function setup_textobjects()
	require("nvim-treesitter-textobjects").setup({
		select = { lookahead = true },
		move = { set_jumps = true },
	})

	local select = require("nvim-treesitter-textobjects.select")
	local move = require("nvim-treesitter-textobjects.move")
	local swap = require("nvim-treesitter-textobjects.swap")

	for key, obj in pairs(select_maps) do
		for prefix, scope in pairs({ a = "outer", i = "inner" }) do
			local query = "@" .. obj .. "." .. scope
			vim.keymap.set({ "x", "o" }, prefix .. key, function()
				select.select_textobject(query, "textobjects")
			end, { desc = "Select " .. obj .. " " .. scope })
		end
	end

	for key, query in pairs(move_maps) do
		local upper = key:upper()
		local modes = { "n", "x", "o" }
		vim.keymap.set(modes, "]" .. key, function()
			move.goto_next_start(query, "textobjects")
		end, { desc = "Next " .. query .. " start" })
		vim.keymap.set(modes, "]" .. upper, function()
			move.goto_next_end(query, "textobjects")
		end, { desc = "Next " .. query .. " end" })
		vim.keymap.set(modes, "[" .. key, function()
			move.goto_previous_start(query, "textobjects")
		end, { desc = "Previous " .. query .. " start" })
		vim.keymap.set(modes, "[" .. upper, function()
			move.goto_previous_end(query, "textobjects")
		end, { desc = "Previous " .. query .. " end" })
	end

	for key, query in pairs(swap_maps) do
		vim.keymap.set("n", ">" .. key, function()
			swap.swap_next(query)
		end, { desc = "Swap next " .. query })
		vim.keymap.set("n", "<" .. key, function()
			swap.swap_previous(query)
		end, { desc = "Swap previous " .. query })
	end
end

function M.setup()
	-- main branch: setup() only takes install_dir; highlight/indent are started per buffer.
	require("nvim-treesitter").install(parsers)

	vim.treesitter.language.register("yaml", "yaml.docker-compose")

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
		callback = function(args)
			if not pcall(vim.treesitter.start, args.buf) then
				return
			end
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})

	setup_textobjects()
end

return M
