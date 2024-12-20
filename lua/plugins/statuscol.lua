return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			segments = {
				{ text = { " " } },
				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				{ text = { " " } },
			},
		})
	end,
}
