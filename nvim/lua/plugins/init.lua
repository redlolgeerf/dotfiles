return {
	-- black and white colorscheme
	'Lokaltog/vim-monotone',
	'bluz71/vim-moonfly-colors',

	-- show lsp data in status line
	'nvim-lua/lsp-status.nvim',
	'RishabhRD/nvim-lsputils',
	-- app for snippets
	--'SirVer/ultisnips',
	-- snippets themselves
	'honza/vim-snippets',

	--completion
	{
		'saghen/blink.cmp',
		-- optional: provides snippets for the snippet source
		dependencies = { 'rafamadriz/friendly-snippets' },

		-- use a release tag to download pre-built binaries
		version = '1.*',
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			keymap = { preset = 'enter' },

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = true } },
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
		},
		opts_extend = { "sources.default" }
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = { 'saghen/blink.cmp' },

		-- example using `opts` for defining servers
		opts = {
			servers = {
				lua_ls = {}
			}
		},
		config = function(_, opts)
			local lspconfig = require('lspconfig')
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
		end
	},
	{
		'fannheyward/coc-pyright'
	},

	-- signatures
	"ray-x/lsp_signature.nvim",

	-- treesitter: syntax highligh, indent and folding
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
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
		requires = {'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons'},
		event = 'VimEnter',
		--config = function() require'vgit'.setup() end,
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
		build = 'mkdp#util#install()',
		ft = {'markdown', 'vim-plug'},
	},

	'folke/tokyonight.nvim',
}
