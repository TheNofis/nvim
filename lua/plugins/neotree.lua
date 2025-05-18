vim.cmd([[let g:neo_tree_remove_legacy_commands = 1]])
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

local function dirname(path)
	return path:match("(.*/)")
end

local function basename(path)
	return path:match(".*/([^/]+)$")
end

local function stem(path)
	return basename(path):match("(.+)%..+$") or basename(path)
end

local function rel_path(from, to)
	local from_dir = dirname(from)
	local to_path = to

	if to_path:sub(1, #from_dir) == from_dir then
		local rel = to_path:sub(#from_dir + 1)
		return rel:gsub("%.tsx?$", ""):gsub("%.jsx?$", ""):gsub("%.ts$", ""):gsub("%.js$", ""):gsub("\\", "/")
	else
		return to_path:gsub("%.tsx?$", ""):gsub("%.jsx?$", ""):gsub("%.ts$", ""):gsub("%.js$", ""):gsub("\\", "/")
	end
end

local function rename_and_update_imports(state)
	local node = state.tree:get_node()
	local old_path = node:get_id()
	local old_name = node.name

	vim.ui.input({ prompt = "New Name: ", default = old_name }, function(new_name)
		if not new_name or new_name == "" or new_name == old_name then
			return
		end

		local old_dir = dirname(old_path)
		local new_path = old_dir .. new_name

		local ok, err = os.rename(old_path, new_path)
		if not ok then
			print("Ошибка переименования: " .. err)
			return
		end

		vim.cmd("edit " .. new_path)

		local old_buf = vim.fn.bufnr(old_path)
		if old_buf ~= -1 then
			vim.api.nvim_buf_delete(old_buf, { force = true })
		end

		local import_basename = stem(old_path)

		local cwd = vim.loop.cwd()
		local rg_cmd = string.format("rg -l '%s' %s", import_basename, cwd)

		local handle = io.popen(rg_cmd)
		local result = handle:read("*a")
		handle:close()

		for file in result:gmatch("[^\r\n]+") do
			local old_rel = rel_path(file, old_path)
			local new_rel = rel_path(file, new_path)

			local function escape(str)
				return str:gsub("([%.%-%/])", "\\%1")
			end

			local sed_old = escape(old_rel)
			local sed_new = escape(new_rel)

			local sed_cmd = string.format("sed -i 's/%s/%s/g' %s", sed_old, sed_new, file)
			os.execute(sed_cmd)
		end
	end)
end

require("neo-tree").setup({
	window = {
		position = "left",
		width = 30,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			R = "rename_and_update_imports",
		},
	},
	commands = {
		rename_and_update_imports = rename_and_update_imports,
	},
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		follow_current_file = {
			enabled = true,
			leave_dirs_open = true,
		},
		group_empty_dirs = false,
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
	},
	git_status = {
		symbols = {
			-- Change type
			added = " ", -- or "✚", but this is redundant info if you use git_status_colors on the name
			modified = " ", -- or "", but this is redundant info if you use git_status_colors on the name
			deleted = "✖", -- this can only be used in the git_status source
			renamed = "󰁕", -- this can only be used in the git_status source
			-- Status type
			untracked = "",
			ignored = "",
			unstaged = "☒",
			staged = "",
			conflict = "",
		},
	},
	source_selector = {
		statusline = true,
		sources = {
			{ source = "filesystem", display_name = " 󰉓 File" },
			{ source = "git_status", display_name = " 󰊢 Git" },
		},
		content_layout = "center",
	},
	enable_git_status = true,
	close_if_last_window = false,
})
