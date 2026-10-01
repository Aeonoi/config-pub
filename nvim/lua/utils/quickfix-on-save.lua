-- For more info: https://neovim.io/doc/user/diagnostic.html
-- Function to show or close the location list based on diagnostics
local function show_or_close_diagnostics()
	local diagnostics = vim.diagnostic.get(0)
	local loclist = vim.fn.getloclist(0)

	-- If there are diagnostics, open the location list
	if #diagnostics > 0 then
		vim.diagnostic.setloclist()
		vim.cmd("lopen")
		vim.cmd("wincmd J")
		vim.cmd(string.format("resize 6"))
	end
end

vim.keymap.set("n", "<leader>q", function()
	show_or_close_diagnostics()
end, { desc = "Toggle Quickfix List" })
