local treesitter = require('nvim-treesitter')
treesitter.setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}
treesitter.install { 'rust', 'python', 'html', 'json', 'lua' }
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python' },
  callback = function() vim.treesitter.start() end,
})
vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo[0][0].foldmethod = 'expr'
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--vim.wo.foldenable=false -- can be enabled directly in opened file - using 'zi' - toogle fold
