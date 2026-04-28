require("codeium").setup({
	detect_proxy = true,
	enable_cmp_source = false,
	virtual_text = {
		enabled = true,
		manual = false,
		idle_delay = 0,
		key_bindings = { accept = "<Leader><Tab>" },
	},
})
