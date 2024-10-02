local lsp = require('lspconfig')
local api = vim.api
local configs = require('lspconfig/configs')
local util = require 'lspconfig/util'
local cwd = vim.loop.cwd





--[[
Helper Functions
--]]

--A custom mapper function to make mapping our lsp functions to vim key sequences less verbose
local mapper = function(mode, key, result)
  api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua "..result.."<cr>", {noremap = true, silent = true})
end

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)


--[[
Attach Function
--]]
--When our LSP starts, this is what happens. Completion enabled, set some mappings, print lsp starting message
local custom_attach = function(client,bufnr) --> Added client,bufnr works also without, inspo from https://github.com/kuator/nvim/blob/master/lua/plugins/lsp.lua
  require "lsp_signature".on_attach()
  -- See: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration
	  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

  -- Keybindings for LSPs
  --mapper('n', 'gh', 'vim.lsp.buf.hover()')
  --mapper('n', 'gD', 'vim.lsp.buf.implementation()')
  --mapper('n', '<c-k>', 'vim.lsp.buf.signature_help()')
  --mapper('n', '1gD', 'vim.lsp.buf.type_definition()')
  --mapper('n', 'g0', 'vim.lsp.buf.document_symbol()')
  --mapper('n', 'gW', 'vim.lsp.buf.workspace_symbol()')
end

--[[
Language Configs
--]]
lsp.pyright.setup{
  on_attach = custom_attach
}
lsp.gopls.setup{
  on_attach = custom_attach
}
lsp.html.setup{
  on_attach = custom_attach
}
lsp.vimls.setup{
  on_attach = custom_attach
}
lsp.rust_analyzer.setup{
  on_attach = custom_attach
}
--lsp.tsserver.setup{
  --on_attach = custom_attach
--}
lsp.terraformls.setup{
  on_attach = custom_attach
}
lsp.ruff_lsp.setup{
  on_attach = custom_attach
}
