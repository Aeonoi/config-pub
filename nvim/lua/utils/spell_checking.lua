-- https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/user/edit_text.lua
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("edit_text", { clear = true }),
	pattern = { "gitcommit", "markdown", "txt", "text" },
	desc = "Enable spell checking and text wrapping for certain filetypes",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
		-- vim.opt_local.conceallevel = 2
	end,
})
