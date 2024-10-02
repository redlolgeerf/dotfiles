-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Automatically install pckr
local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
	-- black and white colorscheme
	'Lokaltog/vim-monotone',
	'bluz71/vim-moonfly-colors',

	-- settings for lsp
	'neovim/nvim-lspconfig',
	-- show lsp data in status line
	'nvim-lua/lsp-status.nvim',
	'RishabhRD/nvim-lsputils',
	-- app for snippets
	'SirVer/ultisnips',
	-- snippets themselves
	'honza/vim-snippets',

	--completion
	{
		'ms-jpq/coq_nvim',
		run = ':COQdeps',
		branch = 'coq',
		vim.api.nvim_exec(
			[[
			let g:coq_settings = { 'auto_start': 'shut-up' }
			]],
			true
		),
	},
	{
		'ms-jpq/coq.artifacts',
		branch = 'artifacts'
	},

	-- signatures
	"ray-x/lsp_signature.nvim",

	-- treesitter: syntax highligh, indent and folding
	{
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
	},

	-- indent guide for blank lines
	'lukas-reineke/indent-blankline.nvim',

	-- check code syntax
	{
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
	},

	-- comment/uncomment
	{
		'scrooloose/nerdcommenter',
		--config = 'vim.cmd[[let g:NERDCreateDefaultMappings = 1]]'
	},

	-- actions with quotes and brackets
	'tpope/vim-surround',

	-- functions for working with git
	{ 
		'tanvirtin/vgit.nvim',
		requires = 'nvim-lua/plenary.nvim'
	},

	-- generate permalinks
	{
		'ruifm/gitlinker.nvim',
		requires = 'nvim-lua/plenary.nvim',
	},


	-- highlight multiple words
	{
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
	},

	-- run tests
	{
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
	},

	-- reuse terminal
	{
		'kassio/neoterm',
		config = function()
			vim.api.nvim_exec(
				[[
				let g:neoterm_default_mod = "botright"
				]],
				false
			)
		end
	},

	-- fuzzy selection of stuff
	'nvim-telescope/telescope-ui-select.nvim',
	{
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	},

	{
		'AckslD/nvim-pytrize.lua',
	},

	{ 
		'iamcco/markdown-preview.nvim',
		run = 'mkdp#util#install()',
		ft = {'markdown', 'vim-plug'},
	},

	'folke/tokyonight.nvim',

}
