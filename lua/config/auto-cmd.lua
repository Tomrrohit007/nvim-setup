vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "*",
	callback = function()
		if vim.bo.modified then
			vim.cmd("silent! write")
		end
	end,
})
