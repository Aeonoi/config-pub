-- Opens neovim into oil
vim.opt.shortmess:append("I")

vim.api.nvim_create_autocmd("UIEnter", {
	once = true,
	callback = function()
		if vim.fn.argc() == 0 then
			vim.schedule(function()
				-- Hides the default splash screen
				vim.cmd("silent! bdelete")
				require("oil").open()
			end)
		end
	end,
})
