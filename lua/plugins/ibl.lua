-- RAINBOWS
-- local highlight = {
-- 	"RainbowRed",
-- 	"RainbowYellow",
-- 	"RainbowBlue",
-- 	"RainbowOrange",
-- 	"RainbowGreen",
-- 	"RainbowViolet",
-- 	"RainbowCyan",
-- }
-- local hooks = require("ibl.hooks")
--
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
-- 	vim.api.nvim_set_hl(0, "RainbowRed", { fg = vim.g.terminal_color_1 })
-- 	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = vim.g.terminal_color_3 })
-- 	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = vim.g.terminal_color_4 })
-- 	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = vim.g.terminal_color_9 })
-- 	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = vim.g.terminal_color_2 })
-- 	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = vim.g.terminal_color_5 })
-- 	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = vim.g.terminal_color_6 })
-- end)

-- vim.g.rainbow_delimiters = { highlight = highlight }

-- require("ibl").setup({ indent = { highlight = highlight, char = "│" } })
-- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
require("ibl").setup({ indent = { char = "│" } })
