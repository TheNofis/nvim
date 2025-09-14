local stages = require("notify.stages.fade")("bottom_up")

require("notify").setup({
	max_width = 60,
	max_height = 10,

	render = "compact",

	stages = {
		function(...)
			local opts = stages[1](...)
			if opts then
				opts.border = "none"
				opts.height = 1
				opts.row = opts.row + 1
			end
			return opts
		end,
		unpack(stages, 2),
	},
	timeout = 1000,
})
