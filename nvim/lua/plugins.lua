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

  -- fuzzy selection of stuff
  use {
	  'nvim-telescope/telescope.nvim',
	  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- visual guide for indents
  use 'glepnir/indent-guides.nvim'

  -- check code syntax
  use {
	  "dense-analysis/ale",
	  config = function()
		  vim.api.nvim_exec(
		  [[
		  let g:ale_linters = {'go': ['gofmt', 'golint', 'gometalinter'], 'python': ['pylint'], 'javascript': ['eslint']}
		  let g:ale_echo_msg_error_str = 'E'
		  let g:ale_echo_msg_warning_str = 'W'
		  let g:ale_sign_error = '✘'
		  let g:ale_sign_warning = '⚠'
		  let g:ale_lint_on_enter = 0 "Don't lint on enter hope this speeds things up/prevents lag
		  ]],
		  false
		  )
	  end
  }

  end)
