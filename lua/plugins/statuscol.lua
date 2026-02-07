return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			segments = {
				{
					sign = { name = { "Dap" }, maxwidth = 1, auto = true },
					click = "v:lua.ScSa",
				},
				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				{ text = { " " } },
			},
		})
	end,
}
