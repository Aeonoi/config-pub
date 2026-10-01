return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		opts = {
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			highlight = {
				enable = true,

				disable = function(lang, buf)
					local max_filesize = 10 * 1024 -- 10 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,

				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,

				additional_vim_regex_highlighting = false,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
