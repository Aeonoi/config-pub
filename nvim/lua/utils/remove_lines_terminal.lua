local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup("RemoveLnTerminal"),
	callback = function()
		vim.wo.number = false -- Disable line numbers
		vim.wo.relativenumber = false -- Disable relative line numbers (if enabled)
	end,
})
