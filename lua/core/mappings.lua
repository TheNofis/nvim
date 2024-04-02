vim.g.mapleader = " "

-- NeoTree
vim.keymap.set('n', '<Leader>e', ':Neotree toggle<CR>')

-- ToggleTerm
vim.keymap.set('n', '<F7>', ':ToggleTerm direction=float<CR>')

-- Save / Exit
vim.keymap.set('n', '<c-s>', ':w<CR>')
vim.keymap.set('n', '<c-q>', ':q<CR>')

-- TAB SWITCH
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<s-Tab>', ':BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<leader>x', ':bdelete<CR>:bNext<CR>')

