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
  -- ui for lsp
  use 'glepnir/lspsaga.nvim'
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
		  augroup FormatAutogroup
		    autocmd!
		    autocmd BufWritePost *.py,*.lua FormatWrite
		  augroup END
		  ]],
		  true
		  )
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
  use 'tpope/vim-fugitive'

  -- use Gbrowse with gitlab
  use {
	  'shumphrey/fugitive-gitlab.vim',
	  config = 'vim.cmd()',
	  config = function()
		  vim.api.nvim_exec(
		  [[
				let g:fugitive_gitlab_domains = ["http://gitlab.dev.ivi.ru/"]
		  ]],
		  false
		  )
	  end
  }

  -- compare file with other commits
  use 'gregsexton/gitv'

  -- switch language on mode change
  use {
	  'lyokha/vim-xkbswitch',
	  config = 'vim.cmd[[let g:XkbSwitchEnabled = 1]]'
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
  use {'camspiers/snap' , rocks = {'fzy'}}


  -- code formatting
  use {
	  'mhartington/formatter.nvim',
	  rocks = {'fzy'},
	  config = function()
		  require('formatter').setup({
			  logging = false,
			  filetype = {
				  lua = {
					  -- luafmt
					  function()
						  return {
							  exe = "luafmt",
							  args = {"--indent-count", 2, "--stdin"},
							  stdin = true
						  }
					  end
				  },
				  python = {
					  function()
						  return {
							  exe = "black",
							  args = {vim.api.nvim_buf_get_name(0)},
							  stdin = false,
						  }
					  end
				  }
			  }
		  })

		  vim.api.nvim_exec(
		  [[
		  augroup FormatAutogroup
		    autocmd!
		    autocmd BufWritePost *.py,*.lua FormatWrite
		  augroup END
		  ]],
		  true
		  )
	  end
  }


  end)
