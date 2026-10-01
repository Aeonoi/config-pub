local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("ChangeGruvboxHighlights"),
	callback = function(event)
		if vim.api.nvim_get_var("colors_name") == "gruvbox-material" then
			-- HIGHLIGHTS ONLY FOR GRUVBOX-MATERIAL
			-- set the colors for the line numbers
			vim.api.nvim_set_hl(0, "LineNr", { link = "Green" })
			vim.api.nvim_set_hl(0, "LineNrAbove", { link = "Grey" })
			vim.api.nvim_set_hl(0, "LineNrBelow", { link = "LineNrAbove" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { link = "LineNr" })

			-- change the virutal text colors
			vim.api.nvim_set_hl(0, "VirtualTextError", { link = "Red" })
			vim.api.nvim_set_hl(0, "VirtualTextInfo", { link = "Blue" })
			vim.api.nvim_set_hl(0, "VirtualTextWarn", { link = "Yellow" })
			vim.api.nvim_set_hl(0, "VirtualTextHint", { link = "Green" })

			-- Change the colors of gitsigns
			vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "Orange" })
			vim.api.nvim_set_hl(0, "GitSignsChanged", { link = "Blue" })
			vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "Red" })

			-- Make proper bordered borders
			vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
			vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
			vim.api.nvim_set_hl(0, "FloatTitle", { link = "Normal" })
		end
	end,
})
