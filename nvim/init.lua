require('plugins')
-- recompile plugin settings on save
vim.api.nvim_command('autocmd BufWritePost plugins.lua PackerCompile')

require('theme')
require('settings')
require('lsp_configs')
require('mappings')
