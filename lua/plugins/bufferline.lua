return {
	"akinsho/bufferline.nvim",
	version = "*",
	config = function()
		require("bufferline").setup({})
		vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "None" }) -- Empty space background on tabline
	end,
}
