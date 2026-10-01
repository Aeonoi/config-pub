return {
	{
		"windwp/nvim-ts-autotag",
		ft = { "javascript", "typescript", "html", "css", "javascriptreact", "typescriptreact", "htmlangular" },
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = true, -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				per_filetype = {
					["html"] = {
						enable_close = true,
					},
				},
			})
		end,
	},
	{
		"folke/ts-comments.nvim",
		ft = { "typescript", "javascript" },
		opts = {},
	},
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	event = "InsertEnter",
	-- 	config = true,
	-- 	opts = {
	-- 		map_cr = true,
	-- 	},
	-- },
	-- better %
	{
		"andymass/vim-matchup",
		ft = { "tex" },
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			vim.g.matchup_matchparen_enabled = 1 -- 0 to disable highligts
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			local surround = require("mini.surround")
			surround.setup({
				mappings = {
					add = "sa", -- Add surrounding in Normal and Visual modes
					delete = "sd", -- Delete surrounding

					find = "sf", -- Find surrounding (to the right)
					find_left = "sF", -- Find surrounding (to the left)

					highlight = "sH", -- Highlight surrounding
					replace = "sr", -- Replace surrounding

					update_n_lines = "sn", -- Update `n_lines`

					suffix_last = "l", -- Suffix to search with "prev" method
					suffix_next = "n", -- Suffix to search with "next" method
				},
			})
		end,
	},
}
