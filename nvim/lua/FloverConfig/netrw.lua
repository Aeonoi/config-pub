vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.cmd([[ let g:netrw_list_hide='.*\.un\~$' ]])
-- https://stackoverflow.com/questions/39961981/how-to-hide-in-netrw-vim hides the ./ and ../
-- vim.cmd([[let g:netrw_list_hide= '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$']])
