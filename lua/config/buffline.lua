local M = {}

function M.setup()
	local get_hex = require("cokeline.hlgroups").get_hl_attr

	local red = vim.g.terminal_color_1
	local yellow = vim.g.terminal_color_3
	local green = vim.g.terminal_color_2
	local purple = vim.g.terminal_color_5
	local normal_bg = get_hex("Normal", "bg")
	local dark_bg = "#1E2127"
	local mute_fg = get_hex("Comment", "fg")
	local white_fg = get_hex("Normal", "fg")

	require("cokeline").setup({
		default_hl = {
			fg = function(buffer)
				return buffer.is_focused and white_fg or mute_fg
			end,
			bg = function(buffer)
				return buffer.is_focused and normal_bg or dark_bg
			end,
		},
		sidebar = {
			filetype = { "NvimTree", "neo-tree" },
			components = {
				{
					text = "          Nvim Tree",
					bg = function()
						return get_hex("NvimTreeNormal", "bg")
					end,
					bold = true,
				},
			},
		},
		components = {
			{
				bg = function(buffer)
					if buffer.is_focused == false then
						return dark_bg
					end
					return buffer.is_first and normal_bg or dark_bg
				end,
				text = "▕",
				fg = function(buffer)
					if buffer.is_focused then
						return normal_bg
					end
					return buffer.is_first and dark_bg or mute_fg
				end,
			},
			{
				text = "▊ ",
				fg = function(buffer)
					return buffer.is_focused and white_fg or dark_bg
				end,
			},
			{ text = "  " },
			{
				text = function(buffer)
					return buffer.devicon.icon
				end,
				fg = function(buffer)
					return buffer.devicon.color
				end,
			},
			{
				text = " ",
				on_click = function()
					return false
				end,
			},
			{
				text = function(buffer)
					return buffer.filename .. "  "
				end,
				bold = function(buffer)
					return buffer.is_focused
				end,
				italic = function(buffer)
					return buffer.is_focused
				end,
			},
			{ text = " " },
			{
				text = function(buffer)
					if buffer.diagnostics.errors > 0 then
						return " "
					elseif buffer.is_readonly then
						return " "
					elseif buffer.diagnostics.warnings > 0 then
						return " "
					elseif buffer.diagnostics.hints > 0 then
						return " "
					elseif buffer.is_modified then
						return "● "
					end
					return " "
				end,
				fg = function(buffer)
					if buffer.diagnostics.errors > 0 or buffer.is_readonly then
						return red
					elseif buffer.diagnostics.warnings > 0 or buffer.is_modified then
						return yellow
					elseif buffer.diagnostics.hints > 0 then
						return purple
					elseif buffer.is_modified == false then
						return green
					end
					return white_fg
				end,
			},
			{ text = " " },
		},
	})

	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#16181C" })
end

return M
