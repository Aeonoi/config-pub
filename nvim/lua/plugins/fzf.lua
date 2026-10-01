return {
	"ibhagwan/fzf-lua",
	config = function()
		-- stop putting a giant window over my editor
		require("fzf-lua").setup({
			winopts = {
				preview = {
					hidden = true,
				},
			},
			files = {
				file_icons = false,
				git_icons = true,
				_fzf_nth_devicons = true,
			},
			buffers = {
				file_icons = true,
				git_icons = true,
			},
			fzf_opts = {
				-- no reverse view
				["--layout"] = "default",
			},
			keymap = {
				-- File picker
				vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>"),
				-- Grep
				vim.keymap.set("n", "<leader>/", ":FzfLua grep_project<CR>"),
				-- Git
				vim.keymap.set("n", "<leader>fg", ":FzfLua git_files<CR>"),
				-- Undo tree
				vim.keymap.set("n", "<leader>u", function()
					FzfLua.undotree({
						winopts = { preview = { hidden = false } },
					})
				end),
			},
		})
	end,
}
