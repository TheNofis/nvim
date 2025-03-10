-- Basic
require("core.plugins")
require("core.mappings")
require("core.configs")
require("core.colorscheme")

-- Plugins

-- VISUAL
require("plugins.neotree")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.outline")
require("plugins.lualine")
require("plugins.buffline")
require("plugins.highlight-colors")

-- FORMATTER
require("plugins.nullls")
require("plugins.autopairs")
require("plugins.nvim-ts-autotag")

--FITCH
require("plugins.cmp")
require("plugins.mason")
require("plugins.comments")

--LINTER
require("plugins.lsp")
require("plugins.ibl")
require("plugins.treesitter")

require("plugins.cmdline")
