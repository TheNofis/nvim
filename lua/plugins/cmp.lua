local cmp = require("cmp")
local types = require("cmp.types")

require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			-- Сначала показываем path-результаты
			function(entry1, entry2)
				local name1 = entry1.source.name
				local name2 = entry2.source.name
				if name1 == name2 then
					return nil
				end
				if name1 == "path" then
					return true
				end
				if name2 == "path" then
					return false
				end
			end,
			-- остальные компараторы cmp
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),

	sources = cmp.config.sources({
		{ name = "luasnip", option = { keyword_pattern = [[[\w<>]*]] } },
		{
			name = "nvim_lsp",
			entry_filter = function(entry)
				local kind = entry:get_kind()
				if kind == types.lsp.CompletionItemKind.Property then
					return false
				end
				return true
			end,
		},
	}, { { name = "buffer" }, { name = "codeium" } }),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig")["ts_ls"].setup({ capabilities = capabilities })
