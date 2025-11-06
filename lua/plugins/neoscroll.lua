local neoscroll = require("neoscroll")

neoscroll.setup({
	easing_function = "sine",
})

vim.keymap.set({ "", "i" }, "<ScrollWheelUp>", function()
	neoscroll.scroll(-5, true, 50)
end, { noremap = true, silent = true })

vim.keymap.set({ "", "i" }, "<ScrollWheelDown>", function()
	neoscroll.scroll(5, true, 50)
end, { noremap = true, silent = true })
