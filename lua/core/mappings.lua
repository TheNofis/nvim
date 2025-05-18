vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap

-- NeoTree
map("n", "<Leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
map("n", "<Leader>g", ":Neotree toggle source=git_status<CR>", { noremap = true, silent = true })

-- Save / Exit
map("n", "<c-s>", ":w<CR>", { noremap = true, silent = true })
map("n", "<c-q>", ":q<CR>", { noremap = true, silent = true })

-- TAB SWITCH
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
map("n", "<s-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
map("n", "<Leader>x", ":bdelete<CR>:bNext<CR>", { noremap = true, silent = true })

map("n", "<c-right>", ":vertical resize -5<CR>", { noremap = true, silent = true })
map("n", "<c-left>", ":vertical resize +5<CR>", { noremap = true, silent = true })
map("n", "<c-up>", ":resize -5<CR>", { noremap = true, silent = true })
map("n", "<c-down>", ":resize +5<CR>", { noremap = true, silent = true })

-- BUFFER SWITCH
map("n", "<c-h>", ":wincmd h<CR>", { noremap = true, silent = true })
map("n", "<c-l>", ":wincmd l<CR>", { noremap = true, silent = true })

-- GIT
map("n", "<Leader>s", ":Telescope git_status<CR>", { noremap = true, silent = true })
map("n", "<Leader>c", ":Telescope git_commits<CR>", { noremap = true, silent = true })

map("n", "<Esc>", ":nohlsearch<Bar>:echo<CR>", { silent = true })

vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
