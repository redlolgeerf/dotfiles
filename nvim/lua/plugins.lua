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
  -- app for snippets
  use 'SirVer/ultisnips'
  -- snippets themselves
  use 'honza/vim-snippets'

	--completion
	use {
		'ms-jpq/coq_nvim',
		run = ':COQdeps',
		branch = 'coq',
		vim.api.nvim_exec(
			[[
		  let g:coq_settings = { 'auto_start': 'shut-up' }
			]],
			true
		),
	}
	use {
		'ms-jpq/coq.artifacts',
		branch = 'artifacts'
	}

  -- signatures
  use {
	  "ray-x/lsp_signature.nvim",
  }

  -- treesitter: syntax highligh, indent and folding
  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = ':TSUpdate',
  }

  -- indent guide for blank lines
  use {
	  'lukas-reineke/indent-blankline.nvim'
  }

  -- check code syntax
  use {
	  "dense-analysis/ale",
	  config = function()
		  vim.api.nvim_exec(
		  [[
		  let g:ale_linters = {'go': ['gofmt', 'golint', 'gometalinter'], 'python': [], 'javascript': ['eslint']}
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

  -- comment/uncomment
  use {
	  'scrooloose/nerdcommenter',
	  config = 'vim.cmd[[let g:NERDCreateDefaultMappings = 1]]'
  }

  -- actions with quotes and brackets
  use 'tpope/vim-surround'

  -- functions for working with git
  use { 
	  'tanvirtin/vgit.nvim',
	  requires = 'nvim-lua/plenary.nvim'
  }

  -- generate permalinks
  use {
	  'ruifm/gitlinker.nvim',
	  requires = 'nvim-lua/plenary.nvim',
  }


  -- highlight multiple words
  use {
	  'lfv89/vim-interestingwords',
	  config = function()
		  vim.api.nvim_exec(
		  [[
		  let g:interestingWordsDefaultMappings = 0
          nnoremap <silent> <LocalLeader>k :call InterestingWords('n')<cr>
          vnoremap <silent> <LocalLeader>k :call InterestingWords('v')<cr>
          nnoremap <silent> <LocalLeader>K :call UncolorAllWords()<cr>
          nnoremap <silent> n :call WordNavigation(1)<cr>
          nnoremap <silent> N :call WordNavigation(0)<cr>
		  ]],
		  false
		  )
	  end
  }

  -- run tests
  use {
	  'vim-test/vim-test',
	  config = function()
		  vim.api.nvim_exec(
		  [[
		  let g:test#strategy = "neoterm"
		  let g:test#preserve_screen = 1
		  let g:test#python#runner = 'pytest'
		  ]],
		  false
		  )
	  end
  }

  -- reuse terminal
  use {
	  'kassio/neoterm',
	  config = function()
		  vim.api.nvim_exec(
		  [[
		  let g:neoterm_default_mod = "botright"
		  ]],
		  false
		  )
	  end
  }

  -- fuzzy selection of stuff
  use {'nvim-telescope/telescope-ui-select.nvim' }
  use {
	  'nvim-telescope/telescope.nvim',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { -- pytrize {{{
	  'AckslD/nvim-pytrize.lua',
	  config = 'require("pytrize").setup()',
  } -- }}}

  use { 
	  'iamcco/markdown-preview.nvim',
	  run = 'mkdp#util#install()',
	  ft = {'markdown', 'vim-plug'},
  }

  use {'folke/tokyonight.nvim'}
  use {
  	'gelguy/wilder.nvim',
  	config = function()
	local wilder = require('wilder')
	wilder.setup({
		modes = {':', '/', '?'},
		next_key = '<Tab>',
		previous_key = '<S-Tab>',
		accept_key = '<Down>',
		reject_key = '<Up>',
	})
	wilder.set_option('pipeline', {
		wilder.branch(
			wilder.cmdline_pipeline({
				fuzzy = 1,
				set_pcre2_pattern = 1,
			}),
			wilder.python_search_pipeline({
				pattern = 'fuzzy',
			})
		),
	})

	local highlighters = {
		wilder.pcre2_highlighter(),
		wilder.basic_highlighter(),
	}

	wilder.set_option('renderer', wilder.renderer_mux({
		[':'] = wilder.popupmenu_renderer({
			highlighter = highlighters,
		}),
		['/'] = wilder.wildmenu_renderer({
			highlighter = highlighters,
		}),
	}))
  	end,
  }


end)
