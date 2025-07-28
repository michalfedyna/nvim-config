return {
	"echasnovski/mini.files",
	version = false,
	config = function()
		require("mini.files").setup({
			mappings = {
				close = "<ESC>",
				go_in = "l",
				go_in_plus = "<RETURN>",
				go_out = "h",
				go_out_plus = "H",
				mark_goto = "'",
				mark_set = "m",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
			windows = {
				-- Maximum number of windows to show side by side
				max_number = math.huge,
				-- Whether to show preview of file/directory under cursor
				preview = true,
				-- Width of focused window
				width_focus = 50,
				-- Width of non-focused window
				width_nofocus = 15,
				-- Width of preview window
				width_preview = 50,
			},
		})
	end,
}
