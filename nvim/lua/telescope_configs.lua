-- mappings
vim.api.nvim_set_keymap('n', '<c-p>', '<cmd>Telescope git_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>g', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>l', '<cmd>Telescope loclist<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>t', '<cmd>Telescope current_buffer_tags<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>g', '<cmd>Telescope grep_string<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>b', '<cmd>Telescope git_bcommits<CR>', { noremap = true, silent = true })
