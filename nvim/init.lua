require('config.lazy_bootstrap')
require('config.mappings')
require('config.settings')
require('config.lazy_start')

require('config.theme')
require('config.lsp_configs')
require('config.treesitter_configs')
require('config.telescope_configs')

require('vgit').setup()
require"gitlinker".setup()
