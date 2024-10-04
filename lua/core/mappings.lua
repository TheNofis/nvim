vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap

-- NeoTree
map("n", "<Leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })

-- Save / Exit
map("n", "<c-s>", ":w<CR>", { noremap = true, silent = true })
map("n", "<c-q>", ":q<CR>", { noremap = true, silent = true })

-- TAB SWITCH
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
map("n", "<s-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
map("n", "<Leader>x", ":bdelete<CR>:bNext<CR>", { noremap = true, silent = true })

map("n", "<c-right>", ":vertical resize -5<CR>", { noremap = true, silent = true })
map("n", "<c-left>", ":vertical resize +5<CR>", { noremap = true, silent = true })

-- BUFFER SWITCH
map("n", "<c-h>", ":wincmd h<CR>", { noremap = true, silent = true })
map("n", "<c-l>", ":wincmd l<CR>", { noremap = true, silent = true })

vim.keymap.set("i", "<Leader><Tab>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })
