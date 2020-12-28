-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- black and white colorscheme
  use 'Lokaltog/vim-monotone'

  -- settings for lsp
  use 'neovim/nvim-lspconfig'
  -- show lsp data in status line
  use 'nvim-lua/lsp-status.nvim'
  use 'RishabhRD/nvim-lsputils'
  -- completion from buffers for completion-nvim
  use 'steelsojka/completion-buffers'
  use {
	  "nvim-lua/completion-nvim",
	  config = function()
		  vim.g.completion_chain_complete_list = {
			  default = {
				  { complete_items = { 'lsp' } },
				  { complete_items = { 'buffers' } },
				  { mode = { '<c-p>' } },
				  { mode = { '<c-n>' } }
			  },
		  }
	  end
  }
end)
