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

-- performance
-- vim.opt.lazyredraw = true
-- vim.opt.ttyfast = true

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
-- vim.cmd("colorscheme vim")
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

-- vim.opt.guicursor = ""

-- vim.opt.colorcolumn = "80" -- Gray line on the right side
vim.opt.cmdheight = 1 -- 0 to have no line gap, 1 to have line gap
vim.opt.showmode = true -- disable showing the mode on cmdline
