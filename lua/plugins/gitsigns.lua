local gs = require("gitsigns")

gs.setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},

	current_line_blame = true, -- inline blame
	current_line_blame_opts = {
		delay = 500,
		virt_text_pos = "eol",
	},

	on_attach = function(bufnr)
		local map = function(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
		end

		-- 🔁 навигация по изменениям
		map("n", "]h", gs.next_hunk, "Next Hunk")
		map("n", "[h", gs.prev_hunk, "Prev Hunk")

		-- 🧩 действия с кусками (hunks)
		map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
		map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")

		map("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage Selection")

		map("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Reset Selection")

		-- 📦 файл целиком
		map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
		map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")

		-- 👀 просмотр
		map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, "Blame Line")

		-- 🔍 diff
		map("n", "<leader>hd", gs.diffthis, "Diff This")
		map("n", "<leader>hD", function()
			gs.diffthis("~")
		end, "Diff ~")

		-- ❌ toggle
		map("n", "<leader>ht", gs.toggle_current_line_blame, "Toggle Blame")
	end,
})
