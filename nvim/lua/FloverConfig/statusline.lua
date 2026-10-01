-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
-- TODO: Refactor https://github.com/tjdevries/config.nvim/blob/master/lua/custom/statusline.lua

local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

-- highlight colors for different modes
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#2d353b", bold = true })
-- vim.api.nvim_set_hl(0, "StatusLine", { fg = "#cad3f5", bg = "#363a4f", bold = true })
vim.api.nvim_set_hl(0, "StatusLineExtra", { fg = "#f2c38f", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "StatusLineAccent", { fg = "#ec5f67", bg = "#1e1e3f", bold = true })
vim.api.nvim_set_hl(0, "StatuslineInsertAccent", { fg = "#f2c38f", bg = "#1e1e3f", bold = true })
vim.api.nvim_set_hl(0, "StatuslineVisualAccent", { fg = "#8bd5ca", bg = "#1e1e3f", bold = true })
vim.api.nvim_set_hl(0, "StatuslineCmdLineAccent", { fg = "#8bd5ca", bg = "#1e1e3f", bold = true })
-- vim.api.nvim_set_hl(0, "Green", { fg = "#8bd5ca", bg = "#363a4f", bold = true })

function mode()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_color = "%#Normal#"
	-- if current_mode == "n" then
	-- 	mode_color = "%#StatuslineAccent#"
	-- elseif current_mode == "i" or current_mode == "ic" then
	-- 	mode_color = "%#StatuslineInsertAccent#"
	-- elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
	-- 	mode_color = "%#StatuslineVisualAccent#"
	-- elseif current_mode == "R" then
	-- 	mode_color = "%#StatuslineReplaceAccent#"
	-- elseif current_mode == "c" then
	-- 	mode_color = "%#StatuslineCmdLineAccent#"
	-- elseif current_mode == "t" then
	-- 	mode_color = "%#StatuslineTerminalAccent#"
	-- end
	return string.format("%s %s |", mode_color, modes[current_mode])
end

local function file()
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":.:h")
	local fname = vim.fn.expand("%:t")

	local devicons = require("nvim-web-devicons")
	local file_icon, file_icon_color =
		devicons.get_icon_color(fname, vim.fn.fnamemodify(fname, ":e"), { default = true })

	vim.cmd(string.format("highlight StatusLineIcon guifg=%s guibg=NONE", file_icon_color))

	if fpath == "" or fpath == "." then
		return string.format(" %%#StatusLineIcon#%s %%#Normal#%s %%#Yellow# ", file_icon, fname)
	end

	return string.format(" %%<%%#StatusLineIcon#%s %%#Normal#%s/%s %%#Yellow# ", file_icon, fpath, fname)
end

local function git_head()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	return table.concat({
		"%#Green#  ",
		"%#Normal#",
		git_info.head,
	})
end
local function git_changes()
	local git_info = vim.b.gitsigns_status_dict
	-- minimally show file change
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added and ("%#Orange# " .. git_info.added .. " ") or ""
	local changed = git_info.changed and ("%#Blue# " .. git_info.changed .. " ") or ""
	local removed = git_info.removed and ("%#Red# " .. git_info.removed) or ""
	return table.concat({
		added,
		changed,
		removed,
	})
end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	-- return " %P  [%l:%c] "
	return " %P  %l:%c "
end

-- errs = ' ',
-- warns = ' ',
-- infos = ' ',
-- hints = ' ',

local function diagnostic()
	local diagnostics = {}

	local errors = #vim.diagnostic.get(0, { severity = 1 })
	if errors > 0 then
		table.insert(diagnostics, string.format("%s %d", "%#DiagnosticSignError#\u{ea71}", errors))
	end

	local warnings = #vim.diagnostic.get(0, { severity = 2 })
	if warnings > 0 then
		table.insert(diagnostics, string.format("%s %d", "%#DiagnosticSignWarn#\u{ea71}", warnings))
	end

	local infos = #vim.diagnostic.get(0, { severity = 3 })
	if infos > 0 then
		table.insert(diagnostics, string.format("%s %d", "%#DiagnosticSignInfo#\u{ea71}", infos))
	end

	local hints = #vim.diagnostic.get(0, { severity = 4 })
	if hints > 0 then
		table.insert(diagnostics, string.format("%s %d", "%#DiagnosticSignHint#\u{ea71}", hints))
	end
	-- if errors > 0 then
	-- 	table.insert(diagnostics, string.format("%s %d", "%#DiagnosticSignError#", errors))
	-- end
	--
	-- local warnings = #vim.diagnostic.get(0, { severity = 2 })
	-- if warnings > 0 then
	-- 	table.insert(diagnostics, string.format("%s %d", "%#DiagnosticSignWarn#", warnings))
	-- end
	--
	-- local infos = #vim.diagnostic.get(0, { severity = 3 })
	-- if infos > 0 then
	-- 	table.insert(diagnostics, string.format("%s %d", "%#DiagnosticSignInfo#", infos))
	-- end
	--
	-- local hints = #vim.diagnostic.get(0, { severity = 4 })
	-- if hints > 0 then
	-- 	table.insert(diagnostics, string.format("%s %d", "%#DiagnosticSignHint#", hints))
	-- end

	return table.concat(diagnostics, " ")
end

Statusline = {}

Statusline.active = function()
	return table.concat({
		"%#Statusline#",
		mode(),
		-- git_head(),
		"%#Normal# ",
		-- file(),
		"%f",
		"%m",
		-- "%#Yellow#| ",
		-- require("nvim-navic").get_location(),
		"%=%S ",
		-- diagnostic(),
		" ",
		-- git_changes(),
		"%#Normal#",
		lineinfo(),
	})
end

function Statusline.inactive()
	return table.concat({
		"%#Normal# ",
		"%f ",
		"%m",
		"%=%S ",
		" ",
		"%#Normal#",
		lineinfo(),
	})
end

vim.api.nvim_exec(
	[[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]],
	false
)

-- always use one statusline for splits
vim.opt.laststatus = 2 -- 3 for one statusline for all splits, 2 is default, 0 to turn it off completely
