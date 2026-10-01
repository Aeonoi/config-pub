vim.g.mapleader = " "

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
-- keymap.set({ "i", "n" }, "<c-l>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
-- keymap.set("n", "<leader>gl", "<cmd>lua vim.diagnostic.open_float()<CR>") -- shows the current diagnostic
-- keymap.set("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
-- keymap.set("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
-- keymap.set("n", "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
