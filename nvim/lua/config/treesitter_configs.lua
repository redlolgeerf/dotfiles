local treesitter = require('nvim-treesitter.configs')
treesitter.setup {
	ensure_installed = "all",
	ignore_install = { "phpdoc" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
}

vim.wo.foldmethod="expr"
vim.o.foldexpr="nvim_treesitter#foldexpr()"
--vim.wo.foldenable=false -- can be enabled directly in opened file - using 'zi' - toogle fold
