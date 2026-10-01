vim.api.nvim_create_autocmd("FileType", {
	pattern = { "oil", "dashboard" },
	callback = function()
		vim.opt_local.colorcolumn = ""
	end,
})
