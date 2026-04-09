vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap

--[[ NeoTree ]]
map("n", "<Leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
map("n", "<Leader>ge", ":Neotree toggle source=git_status<CR>", { noremap = true, silent = true })

--[[ Save / Exit ]]
map("n", "<c-s>", ":w<CR>", { noremap = true, silent = true })
map("n", "<c-q>", ":q<CR>", { noremap = true, silent = true })

--[[ Переключение табов и закрытие буфера ]]
map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
map("n", "<s-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
map("n", "<Leader>x", ":bdelete<CR>:bNext<CR>", { noremap = true, silent = true })

--[[ Изменение размера окон ]]
map("n", "<c-right>", ":vertical resize -5<CR>", { noremap = true, silent = true })
map("n", "<c-left>", ":vertical resize +5<CR>", { noremap = true, silent = true })
map("n", "<c-up>", ":resize -5<CR>", { noremap = true, silent = true })
map("n", "<c-down>", ":resize +5<CR>", { noremap = true, silent = true })

--[[ Перемещение между окнами ]]
map("n", "<c-k>", ":wincmd k<CR>", { noremap = true, silent = true })
map("n", "<c-j>", ":wincmd j<CR>", { noremap = true, silent = true })
map("n", "<c-h>", ":wincmd h<CR>", { noremap = true, silent = true })
map("n", "<c-l>", ":wincmd l<CR>", { noremap = true, silent = true })

--[[ GIT ]]
map("n", "<Leader>gs", ":Telescope git_status<CR>", { noremap = true, silent = true })
map("n", "<Leader>gc", ":Telescope git_commits<CR>", { noremap = true, silent = true })
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

--[[ Убираем подсветку поиска по Esc ]]
map("n", "<Esc>", ":nohlsearch<Bar>:echo<CR>", { silent = true })

--[[ LSP ]]
map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
map("n", "<leader>rf", "<cmd>TSToolsRenameFile sync<CR>", { noremap = true, silent = true })
map("n", "<leader>s", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
map("n", "<leader>t", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

--[[ Форматирование ]]
map("v", "<Tab>", ">gv", { noremap = true, silent = true })
map("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

map("n", "<leader>cc", "<cmd>CodexToggle<CR>", { noremap = true, silent = true })

--[[ Удаление без сохранения в регистр ]]
vim.keymap.set("n", "<c-x>", '"_dd')
vim.keymap.set("v", "<c-x>", '"_dd')
