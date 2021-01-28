local saga = require 'lspsaga'

-- add your config value here
-- default value
-- use_saga_diagnostic_handler = 1 // disable the lspsaga diagnostic handler
-- use_saga_diagnostic_sign = 1 // disable the lspsaga diagnostic sign
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- code_action_icon = ' ',
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- definition_preview_icon = '  '
-- 1: thin border | 2: rounded border | 3: thick border
-- border_style = 1
-- max_hover_width = 0 (automatically adjust to the width of current symbol)


saga.init_lsp_saga()

vim.api.nvim_set_keymap('n', 'gh', "<cmd>lua require('lspsaga.provider').lsp_finder()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<LocalLeader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true }) 
vim.api.nvim_set_keymap('n', 'gd', "<cmd>lua require('lspsaga.provider').preview_definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[e', "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']e', "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>", { noremap = true, silent = true })
