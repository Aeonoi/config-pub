return {
	{
		"hrsh7th/nvim-cmp",
		-- event = { "BufReadPost", "BufNewFile" },
		event = "InsertEnter",
		dependencies = {
			-- auto completion
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",

			-- snippet engine
			{
				"L3MON4D3/LuaSnip",
				lazy = true,
				-- dependencies = {
				-- 	"rafamadriz/friendly-snippets",
				-- 	config = function()
				-- 		-- get additional snippets
				-- 		require("luasnip.loaders.from_vscode").lazy_load()
				-- 	end,
				-- },
			},
		},
		config = function()
			local cmp = require("cmp")

			-- cmp icons
			local icons = require("utils.icons")

			-- autopair for function completions
			-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			-- cmp
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				view = {
					entries = "custom",
				},
				formatting = {
					format = function(entry, vim_item)
						vim_item.abbr = string.sub(vim_item.abbr, 1, 40)
						vim_item.kind = string.format("%s%s", (icons.lspkind[vim_item.kind] or ""), vim_item.kind)
						local attached_servers = vim.lsp.get_clients()
						local is_vtsls = false
						for _, client in pairs(attached_servers) do
							if client.name == "vtsls" then
								is_vtsls = true
							end
						end
						if not is_vtsls then
							vim_item.menu = ({
								buffer = "[Buffer]",
								nvim_lsp = "[LSP]",
								luasnip = "[LuaSnip]",
								nvim_lua = "[Lua]",
								latex_symbols = "[LaTeX]",
							})[entry.source.name]
						end
						return vim_item
					end,
				},
				window = {
					completion = {
						scrollbar = true,
						-- border = "rounded",
						-- winhighlight = "NormalFloat:Normal,Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
						-- border = {
						-- 	{ "󱐋", "WarningMsg" },
						-- 	{ "─", "Comment" },
						-- 	{ "╮", "Comment" },
						-- 	{ "│", "Comment" },
						-- 	{ "╯", "Comment" },
						-- 	{ "─", "Comment" },
						-- 	{ "╰", "Comment" },
						-- 	{ "│", "Comment" },
						-- },
						winblend = 0,
					},
					documentation = {
						-- border = "rounded",
						scrollbar = true,
						-- border = {
						-- 	{ "󰙎", "DiagnosticHint" },
						-- 	{ "─", "Comment" },
						-- 	{ "╮", "Comment" },
						-- 	{ "│", "Comment" },
						-- 	{ "╯", "Comment" },
						-- 	{ "─", "Comment" },
						-- 	{ "╰", "Comment" },
						-- 	{ "│", "Comment" },
						-- },
						winblend = 0,
						-- winhighlight = "NormalFloat:Normal,Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
					},
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<C-c>"] = cmp.mapping.abort(),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", group_index = 1 },
					{ name = "buffer", max_item_count = 5, group_index = 2 },
					{ name = "path", max_item_count = 5, group_index = 3 },
					{ name = "luasnip", max_item_count = 3, group_index = 4 },
					{ name = "vim-dadbod-completion" },
				}),
			})
		end,
	},
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {},
	-- 	config = function(_, opts)
	-- 		-- Get signatures (and _only_ signatures) when in argument lists.
	-- 		require("lsp_signature").setup({
	-- 			doc_lines = 0,
	-- 			handler_opts = {
	-- 				border = "none",
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- "github/copilot.vim",
}
