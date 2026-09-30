local map = require("utils.map").set

map("n", "<Leader>e", "<cmd>Neotree toggle<CR>", "Toggle file tree")
map("n", "<Leader>ge", "<cmd>Neotree toggle source=git_status<CR>", "Toggle git tree")

map("n", "<C-s>", "<cmd>w<CR>", "Save file")
map("n", "<C-q>", "<cmd>q<CR>", "Quit window")

map("n", "<Tab>", "<Plug>(cokeline-focus-next)", nil, { noremap = false })
map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", nil, { noremap = false })

map("n", "<C-right>", "<cmd>vertical resize -5<CR>", "Shrink window width")
map("n", "<C-left>", "<cmd>vertical resize +5<CR>", "Grow window width")
map("n", "<C-up>", "<cmd>resize -5<CR>", "Shrink window height")
map("n", "<C-down>", "<cmd>resize +5<CR>", "Grow window height")

map("n", "<C-k>", "<cmd>wincmd k<CR>", "Focus window up")
map("n", "<C-j>", "<cmd>wincmd j<CR>", "Focus window down")
map("n", "<C-h>", "<cmd>wincmd h<CR>", "Focus window left")
map("n", "<C-l>", "<cmd>wincmd l<CR>", "Focus window right")

map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", "Find files")
map("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>", "Live grep")
map("n", "<Leader>fr", "<cmd>Telescope resume<CR>", "Resume telescope")
map("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", "Find buffers")
map("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>", "Help tags")
map("n", "<Leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", "Document symbols")
map("n", "<Leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace symbols")
map("n", "<Leader>fk", "<cmd>Telescope keymaps<CR>", "Keymaps")

map("n", "<Leader>gs", "<cmd>Telescope git_status<CR>", "Git status")
map("n", "<Leader>gc", "<cmd>Telescope git_commits<CR>", "Git commits")
map("n", "<Leader>gb", "<cmd>Telescope git_branches<CR>", "Git branches")
map("n", "<Leader>gd", "<cmd>DiffviewOpen<CR>", "Open diff view")
map("n", "<Leader>gD", "<cmd>DiffviewClose<CR>", "Close diff view")
map("n", "<Leader>gh", "<cmd>DiffviewFileHistory %<CR>", "Current file history")
map("n", "<Leader>gH", "<cmd>DiffviewFileHistory<CR>", "Repository history")
map("n", "<Leader>gp", function()
	require("gitsigns").preview_hunk()
end, "Preview hunk")
map("n", "<Leader>gn", function()
	require("gitsigns").next_hunk()
end, "Next hunk")
map("n", "<Leader>gN", function()
	require("gitsigns").prev_hunk()
end, "Previous hunk")

map("n", "<Esc>", "<cmd>nohlsearch<Bar>echo<CR>", nil)

-- * / # only highlight the word under cursor; then n always goes down, N up.
local function highlight_word()
	local pattern = "\\<" .. vim.fn.expand("<cword>") .. "\\>"
	vim.fn.setreg("/", pattern)
	vim.fn.histadd("/", pattern)
	vim.v.searchforward = 1
	vim.o.hlsearch = true
end
map("n", "*", highlight_word, "Highlight word under cursor")
map("n", "#", highlight_word, "Highlight word under cursor")

map("v", "<Tab>", ">gv", "Indent selection")
map("v", "<S-Tab>", "<gv", "Outdent selection")

map("n", "<leader>aa", "<cmd>CodeCompanionChat Toggle adapter=codex<CR>", "Toggle AI chat")
map("n", "<leader>ai", "<cmd>CodeCompanion<CR>", "AI inline action")
map("v", "<leader>ai", "<cmd>CodeCompanion<CR>", "AI inline action")
map("n", "<leader>ac", "<cmd>CodeCompanionCLI <CR>", "AI CLI")
map("n", "<leader>ar", "<cmd>CodeCompanionActions<CR>", "AI actions")

map("n", "<C-x>", '"_dd', "Delete line without yank")
map("v", "<C-x>", '"_dd', "Delete selection without yank")
