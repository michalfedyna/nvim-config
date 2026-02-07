return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			segments = {
				--[[ {
					text = { "%s" },
					click = "v:lua.ScSa",
					sign = { maxwidth = 1, width = 1 },
					condition = { true },
					auto = false,
				}, ]]
				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				{ text = { " " } },
			},
		})
	end,
}
