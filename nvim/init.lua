-- OPTIONS
vim.g.mapleader = " "
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.scriptencoding = "utf-8"

-- tab spacing
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- numbers on the left
vim.opt.relativenumber = true
vim.opt.number = true

-- turn to false if not worried about "losing" code
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- vim.opt.clipboard = "unnamed,unnamedplus" -- copy to clipboard
vim.opt.clipboard = ""
vim.opt.diffopt:append("iwhite")
vim.opt.diffopt:append("algorithm:histogram")
vim.opt.diffopt:append("indent-heuristic")
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.title = true

vim.g.vim_default_colors = 1
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd([[colorscheme retrobox]])
vim.cmd([[highlight Normal guibg=none]])
vim.cmd([[highlight NonText guibg=none]])

vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"
vim.opt.list = false -- disables the angular brackets for tabs
vim.opt.scrolloff = 8
vim.opt.shell = "fish"
vim.opt.mouse = "a" -- allow for mouse scroll

vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.cursorline = true

vim.opt.inccommand = "split"
vim.opt.smoothscroll = true
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.title = true
vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"
vim.opt.smartcase = true
vim.opt.ignorecase = true -- case insensitive search
vim.opt.completeopt = {
	"menu",
	"menuone",
	"noselect",
	"noinsert",
} -- better completion
vim.opt.pumheight = 100 -- limit completion items
vim.showcmd = true

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

vim.opt.cmdheight = 1 -- 0 to have no line gap, 1 to have line gap
vim.opt.showmode = true -- disable showing the mode on cmdline

-- KEYMAPS
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- inlay hints
keymap.set("n", "<leader>i", function()
	require("utils.inlay_hints").toggleInlayHints()
end)

-- Auto save
keymap.set("n", "<C-s>", ":AsToggle <cr>", opts)

-- Exit terminal mode in terminal
keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

-- Clear search with <esc>
keymap.set({ "i", "n" }, "<c-h>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

--makes search terms stay in the middle
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Tabs
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- yank to clipboard
keymap.set("n", "<leader>y", '"+y')
keymap.set("n", "<leader>yy", '"+yy')
keymap.set("n", "<leader>Y", '"+Y')
keymap.set("x", "<leader>y", '"+y')
keymap.set("x", "<leader>Y", '"+Y')

-- Move selected text up or down
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- delete, not cut
keymap.set("n", "<leader>d", '"_d')
keymap.set("x", "<leader>d", '"_d')

-- keymap.set("n", ";", ":") -- for when shift is not clicked by accident
keymap.set("n", "<leader>fp", "<cmd>Oil --float<CR>", opts) -- opens oil.nvim
keymap.set("i", "<C-f>", "<C-x><C-f>", opts) -- autocompletion for paths

-- Function to create a split and move the cursor to it
local function split_and_focus(direction)
	if direction == "s" then
		vim.cmd("split") -- Create a horizontal split
	elseif direction == "v" then
		vim.cmd("vsplit") -- Create a vertical split
	end
	vim.cmd("wincmd w") -- Move the cursor to the new split
end

-- Create commands for horizontal and vertical splits
vim.api.nvim_create_user_command("HSplit", function()
	split_and_focus("s")
end, {})
vim.api.nvim_create_user_command("VSplit", function()
	split_and_focus("v")
end, {})

-- panes
keymap.set("n", "ss", ":HSplit<Return>", opts) -- split horizontally
keymap.set("n", "sv", ":VSplit<Return>", opts) -- split vertically

-- Switch panes
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize winow
keymap.set("n", "<C-left>", "<C-w><")
keymap.set("n", "<C-right>", "<C-w>>")
keymap.set("n", "<C-up>", "<C-w>+")
keymap.set("n", "<C-down>", "<C-w>-")

keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_prev()
end, opts)
keymap.set("n", "<C-k>", function()
	vim.diagnostic.goto_next()
end, opts)

-- <C-a> is my global leader for tmux - increments
keymap.set("n", "<C-a>", "<nop>")
keymap.set("v", "<C-a>", "<nop>")
keymap.set("n", "<C-Z>", "<nop>")
keymap.set("n", "<C-Z>", "<C-A>")
keymap.set("v", "<C-Z>", "<nop>")
keymap.set("v", "<C-Z>", "<C-A>")

-- quick access to Lazy or Mason
keymap.set("n", "<leader>L", "<cmd>Lazy<CR>")
keymap.set("n", "<leader>M", "<cmd>Mason<CR>")

-- LSP
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
keymap.set("n", "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<CR>")
keymap.set("n", "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>") -- shows the fixes
keymap.set("n", "<leader>gg", "<cmd>lua vim.diagnostic.open_float()<CR>") -- shows the current diagnostic udner the cursor
keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>") -- opens up the manual, the actual implementation of the method
keymap.set("n", "<leader>gw", function()
	vim.lsp.buf.workspace_symbol()
end, opts)
keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>") -- show occurances of currently hovered

-- highlights yanks
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 250,
		})
	end,
})

-- go to last loc when opening a buffer
local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("jump_to_last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

-- Plugins
require("lazy").setup({
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			{
				"L3MON4D3/LuaSnip",
				lazy = true,
			},
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					-- REQUIRED by nvim-cmp. get rid of it once we can
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					-- Accept currently selected item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}, {
					{ name = "path" },
				}),
				experimental = {
					ghost_text = true,
				},
			})

			-- Enable completing paths in :
			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({
					{ name = "path" },
				}),
			})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			-- Get signatures (and _only_ signatures) when in argument lists.
			require("lsp_signature").setup({
				doc_lines = 0,
				handler_opts = {
					border = "none",
				},
			})
		end,
	},
	-- "github/copilot.vim",
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
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = {
					"biome",
				},
				javascriptreact = {
					"biome",
				},
				typescript = {
					"biome",
				},
				typescriptreact = {
					"biome",
				},
				css = {
					"biome",
				},
				html = {
					"biome",
				},
				htmlangular = {
					"prettier",
				},
				json = {
					"biome",
				},
				java = {
					"google_java_format",
				},
			},
			notify_on_error = false,
			default_format_opts = {
				async = true,
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			format_after_save = {
				async = true,
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
	{
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
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", config = function() end },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {}
			)

			-- Server configurations
			local servers = {
				-- https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json#L1063
				vtsls = {
					root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", "jsconfig.json"),
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {
						complete_function_calls = true,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = {
								completeFunctionCalls = true,
							},
							format = {
								enable = false,
							},
							tsserver = {
								maxTsServerMemory = 12288,
							},
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
							},
						},
						javascript = {
							tsserver = {
								maxTsServerMemory = 5120,
							},
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
							},
						},
					},
				},
				clangd = {
					filetypes = { "c", "h", "cpp" },
					cmd = { "clangd", "--background-index" },
					single_file_support = true,
				},
				rust_analyzer = {
					root_dir = lspconfig.util.root_pattern(".git", "Cargo.toml"),
					check = {
						command = "clippy",
						features = "all",
					},
				},
			}

			require("mason").setup()
			require("nvim-web-devicons").setup()
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						if server_name ~= "jdtls" then
							local server = servers[server_name] or {}
							server.capabilities =
								vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
							require("lspconfig")[server_name].setup(server)
						end
					end,
				},
			})
			vim.diagnostic.config({
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					source = "always",
					header = "",
					prefix = "",
				},
				virtual_text = false,
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	-- LaTex
	{
		"lervag/vimtex",
		ft = "tex",
		lazy = false, -- we don't want to lazy load VimTeX
		init = function()
			vim.g.vimtex_view_method = "zathura"

			vim.g.vimtex_compiler_latexmk = {
				options = {
					"-shell-escape",
					"-verbose",
					"-file-line-error",
					"-interaction=nonstopmode",
					"-synctex=1",
					-- "-recorder"
				},
			}
		end,
	},
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
})
