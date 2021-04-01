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
  -- completion
  use {
	  "hrsh7th/nvim-compe",
	  config = function()
		  require'compe'.setup {
			  enabled = true;
			  debug = false;
			  min_length = 1;
			  preselect = 'disable';
			  allow_prefix_unmatch = false;
			  source = {
				  path = true;
				  buffer = true;
				  vsnip = true;
				  nvim_lsp = true;
				  ultisnips = true;
			  };
		  }
	  end
  }

  -- treesitter: syntax highligh, indent and folding
  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = ':TSUpdate',
  }

  -- fuzzy selection of stuff
  use {
	  'nvim-telescope/telescope.nvim',
	  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- indent guide for blank lines
  use {
	  'lukas-reineke/indent-blankline.nvim',
	  branch = "lua"
  }

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

  -- search
  use {
	  'mileszs/ack.vim',
	  config = function()
		  vim.api.nvim_exec(
		  [[
		  if executable('ag')
			  let g:ackprg = 'ag'
		  endif
		  let g:ackhighlight = 1
		  nnoremap <Leader>f :LAck! '\b<C-R>=expand("<cword>")<CR>\b'<CR>
		  nnoremap <Leader>s :LAck! '\b<C-R>=expand("<cword>")<CR>\b' <C-R>=substitute(FugitiveGitDir(), ".git", "", "")<CR>
		  nnoremap <LocalLeader>s :LAck! '\b<C-R>=expand("<cword>")<CR>\b' <C-R>=expand('%:p:h')<CR>
		  ]],
		  false
		  )
	  end
  }

  -- file browser
  use {
	  'ms-jpq/chadtree',
	  branch = 'chad',
	  run = 'python3 -m chadtree deps',
	  config = function()
		vim.api.nvim_set_keymap('n', '<Leader>l', ':CHADopen<CR>', {  noremap = true, silent = true })
	  end
  }
  end)
