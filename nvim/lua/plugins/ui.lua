-- local border = {
-- 	{ "╭", "Comment" },
-- 	{ "─", "Comment" },
-- 	{ "╮", "Comment" },
-- 	{ "│", "Comment" },
-- 	{ "╯", "Comment" },
-- 	{ "─", "Comment" },
-- 	{ "╰", "Comment" },
-- 	{ "│", "Comment" },
-- }
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--     opts = opts or {}
-- 	opts.border = opts.border or border
-- 	return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end

return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- replaces netrw
			default_file_explorer = true,

			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},

			keymaps = {
				["<C-c>"] = "actions.close",
			},

			float = {
				-- change size of floating window
				padding = 10,
			},

			view_options = {
				show_hidden = true,
			},
		},
	},
	{
		"declancm/maximize.nvim",
		config = true,
		init = function()
			vim.keymap.set("n", "<leader>m", function()
				require("maximize").toggle()
			end)
		end,
	},
	{
		"shortcuts/no-neck-pain.nvim",
		version = "*",
		opts = {
			mappings = {
				enabled = true,
				toggle = false,
				toggleLeftSide = false,
				toggleRightSide = false,
				widthUp = false,
				widthDown = false,
				scratchPad = false,
			},
		},
		config = function()
			vim.keymap.set("", "<leader>..", function()
				vim.cmd([[
					:NoNeckPain
					:set formatoptions-=tc linebreak tw=0 cc=0 wrap wm=20 noautoindent nocindent nosmartindent indentkeys=
				]])
				-- make 0, ^ and $ behave better in wrapped text
				vim.keymap.set("n", "0", "g0")
				vim.keymap.set("n", "$", "g$")
				vim.keymap.set("n", "^", "g^")
			end)
		end,
	},
}
