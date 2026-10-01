-- Auto create dir when saving a file, in case some intermediate directory does not exist
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

-- vim.filetype.add({
-- 	pattern = {
-- 		[".*"] = {
-- 			function(path, buf)
-- 				return vim.bo[buf]
-- 						and vim.bo[buf].filetype ~= "bigfile"
-- 						and path
-- 						and vim.fn.getfsize(path) > vim.g.bigfile_size
-- 						and "bigfile"
-- 					or nil
-- 			end,
-- 		},
-- 	},
-- })
--
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	group = augroup("bigfile"),
-- 	pattern = "bigfile",
-- 	callback = function(ev)
-- 		vim.b.minianimate_disable = true
-- 		vim.schedule(function()
-- 			vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
-- 		end)
-- 	end,
-- })
