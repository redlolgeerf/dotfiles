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



--[[
Attach Function
--]]
--When our LSP starts, this is what happens. Completion enabled, set some mappings, print lsp starting message
local custom_attach = function(client,bufnr) --> Added client,bufnr works also without, inspo from https://github.com/kuator/nvim/blob/master/lua/plugins/lsp.lua
  require "lsp_signature".on_attach()
  --vim.lsp.set_log_level('debug') --> ENABLE LOGGING
  -- Move cursor to the next and previous diagnostic
  mapper('n', '<leader>dn', 'vim.lsp.diagnostic.goto_next()')
  mapper('n', '<leader>dp', 'vim.lsp.diagnostic.goto_prev()')
  -- Keybindings for LSPs
  mapper('n', 'gd', 'vim.lsp.buf.definition()')
  mapper('n', 'gh', 'vim.lsp.buf.hover()')
  mapper('n', 'gD', 'vim.lsp.buf.implementation()')
  mapper('n', '<c-k>', 'vim.lsp.buf.signature_help()')
  mapper('n', '1gD', 'vim.lsp.buf.type_definition()')
  mapper('n', 'gr', 'vim.lsp.buf.references()')
  mapper('n', 'g0', 'vim.lsp.buf.document_symbol()')
  mapper('n', 'gW', 'vim.lsp.buf.workspace_symbol()')
  print("LSP Started")
  --vim.fn.nvim_set_keymap("n", "<leader>ge", "<cmd>lua vim.lsp.buf.declaration()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<leader>gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<leader>gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<leader>gt", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<leader>gw", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true, silent = true})
  --vim.fn.nvim_set_keymap("n", "<a-.>", "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true, silent = true})
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
lsp.rls.setup{
  on_attach = custom_attach
}
lsp.tsserver.setup{
  on_attach = custom_attach
}


-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = "lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
