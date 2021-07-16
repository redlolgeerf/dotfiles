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
LSP Configs
--]]

-- async formatting
-- https://www.reddit.com/r/neovim/comments/jvisg5/lets_talk_formatting_again/
vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        vim.api.nvim_command("noautocmd :update")
    end
end

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
  }
)


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
