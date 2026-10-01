-- Configure the highlights of certain highlight groups

-- removes the background of the sign column
vim.cmd([[ highlight SignColumn guifg=none guibg=none]])
vim.cmd([[ highlight YellowSign guibg=none]])
vim.cmd([[ highlight RedSign guibg=none]])
vim.cmd([[ highlight BlueSign guibg=none]])
vim.cmd([[ highlight GreenSign guibg=none]])

-- Gives a nice rounded border for floating borders
vim.cmd([[ highlight HarpoonWindow guifg=none guibg=none]])
vim.cmd([[ highlight HarpoonBorder guifg=none guibg=none]])

-- nvim LSP signature
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { link = "Normal" })

-- Ghost text
vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment" })
vim.api.nvim_set_hl(0, "LspInlayHint", { link = "CmpGhostText" })

-- Fix Notify's colors
vim.cmd([[
  highlight NotifyERRORBorder guifg=#ed8796
  highlight NotifyERRORIcon guifg=#ed8796
  highlight NotifyERRORTitle  guifg=#ed8796
  highlight NotifyINFOBorder guifg=#8aadf4
  highlight NotifyINFOIcon guifg=#8aadf4
  highlight NotifyINFOTitle guifg=#8aadf4
  highlight NotifyWARNBorder guifg=#f5a97f
  highlight NotifyWARNIcon guifg=#f5a97f
  highlight NotifyWARNTitle guifg=#f5a97f
  highlight NotifyBackground guifg=#000000
]])

-- Changes the color of the cursor
-- vim.cmd([[
--   highlight TermCursor cterm=NONE ctermbg=DarkGray guibg=#425047
-- ]])
