return {

	"sschleemilch/slimline.nvim",
	opts = {
		style = "fg",
		spaces = {
			components = "",
			left = "",
			right = "",
		},
	},
	config = function(_, opts)
		vim.o.laststatus = 3 -- Ensure global statusline
		require("slimline").setup(opts)
	end,
}
