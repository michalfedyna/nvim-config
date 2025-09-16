return {
	"folke/snacks.nvim",
	opts = {
		scroll = {
			animate = {
				duration = { step = 5, total = 50 },
				easing = "linear",
			},
			animate_repeat = {
				delay = 100, -- delay in ms before using the repeat animation
				duration = { step = 5, total = 50 },
				easing = "linear",
			},
		},
	},
}
