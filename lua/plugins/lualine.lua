-- local colors = {
-- 	blue = "#61AFEE",
-- 	cyan = "#56B6C2",
-- 	black = "#282C34",
-- 	white = "#ffffff",
-- 	red = "#E06C75",
-- 	violet = "#E5C07B",
-- 	grey = "#373B41",
-- }
--
-- local bubbles_theme = {
-- 	normal = {
-- 		a = { fg = colors.black, bg = colors.violet },
-- 		b = { fg = colors.white, bg = colors.grey },
-- 		c = { fg = colors.black, bg = colors.black },
-- 	},
--
-- 	insert = { a = { fg = colors.black, bg = colors.blue } },
-- 	visual = { a = { fg = colors.black, bg = colors.cyan } },
-- 	replace = { a = { fg = colors.black, bg = colors.red } },
--
-- 	inactive = {
-- 		a = { fg = colors.white, bg = colors.black },
-- 		b = { fg = colors.white, bg = colors.black },
-- 		c = { fg = colors.black, bg = colors.black },
-- 	},
-- }
--
require("lualine").setup({
	options = {
		theme = "onedark",
		component_separators = "|",
		section_separators = { right = "", left = "" },
		disabled_filetypes = { "packer", "neo-tree" },
	},
	sections = {
		lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
		lualine_b = {
			"branch",
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = { "filetype", "progress" },
		lualine_z = {
			{ "location", separator = { right = "" }, left_padding = 2 },
		},
	},
	inactive_sections = {
		lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
		lualine_b = {
			"branch",
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = { "filetype", "progress" },
		lualine_z = {
			{ "location", separator = { right = "" }, left_padding = 2 },
		},
	},
	tabline = {},
	extensions = {},
})

vim.cmd([[
augroup lualine_augroup
    autocmd!
    autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
augroup END
]])
