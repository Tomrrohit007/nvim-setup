return {
	"neanias/everforest-nvim",
	version = false,
	lazy = false,
	priority = 1000,
	config = function()
		require("everforest").setup({
			background = "medium",
			transparent_background_level = 0,
			italics = false,
			disable_italic_comments = false,
			sign_column_background = "none",
			ui_contrast = "low",
			dim_inactive_windows = false,
			diagnostic_virtual_text = "coloured",
			float_style = "bright",
		})
		vim.cmd([[colorscheme everforest]])
	end,
}
