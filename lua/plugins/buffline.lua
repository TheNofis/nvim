local is_picking_focus = require("cokeline.mappings").is_picking_focus
local is_picking_close = require("cokeline.mappings").is_picking_close
local get_hex = require("cokeline.hlgroups").get_hl_attr

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_3
local green = vim.g.terminal_color_2
local purple = vim.g.terminal_color_5

local normalBg = get_hex("Normal", "bg")
local darkBg = "#1E2127"

local muteFg = get_hex("Comment", "fg")
local whiteFg = get_hex("Normal", "fg")

require("cokeline").setup({
	default_hl = {
		fg = function(buffer)
			return buffer.is_focused and whiteFg or muteFg
		end,
		bg = function(buffer)
			return buffer.is_focused and normalBg or darkBg
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
					return darkBg
				end
				return buffer.is_first and normalBg or darkBg
			end,
			text = "▕",
			fg = function(buffer)
				if buffer.is_focused then
					return normalBg
				end
				return buffer.is_first and darkBg or muteFg
			end,
		},
		{
			text = "▊ ",
			fg = function(buffer)
				return buffer.is_focused and whiteFg or darkBg
			end,
		},
		{
			text = "  ",
		},
		{
			text = function(buffer)
				return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. " " or buffer.devicon.icon
			end,
			fg = function(buffer)
				return (is_picking_focus() and yellow) or (is_picking_close() and red) or buffer.devicon.color
			end,
			italic = function()
				return (is_picking_focus() or is_picking_close())
			end,
			bold = function()
				return (is_picking_focus() or is_picking_close())
			end,
		},
		{
			text = " ",
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
		{
			text = " ",
		},
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
				if buffer.diagnostics.errors > 0 then
					return red
				elseif buffer.is_readonly then
					return red
				elseif buffer.diagnostics.warnings > 0 then
					return yellow
				elseif buffer.diagnostics.hints > 0 then
					return purple
				elseif buffer.is_modified then
					return yellow
				elseif buffer.is_modified == false then
					return green
				end

				return whiteFg
			end,
		},
		{
			text = " ",
		},
	},
})

vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#16181C" })
