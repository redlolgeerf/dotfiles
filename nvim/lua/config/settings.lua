-- general vim settings
local cmd = vim.api.nvim_command

local apply_options = function(opts)
  for k, v in pairs(opts) do
    if v == true then
      cmd('set ' .. k)
    elseif v == false then
      cmd(string.format('set no%s', k))
    else
      cmd(string.format('set %s=%s', k, v))
    end
  end
end

local options = {
  autoindent = true, -- enable autoindent
  backup = false, -- disable backup
  cursorline = true, -- enable cursorline
  --autowrite = true, -- autowrite buffer when it's not focused
  hidden = true, -- keep hidden buffers
  hlsearch = true, -- highlight matching search
  ignorecase = true, -- case insensitive on search
  incsearch = true, -- case insensitive on search
  lazyredraw = true, -- lazyredraw to make macro faster
  --list = true, -- display listchars
  number = true, -- enable number
  showmode = false, -- don't show mode
  smartcase = true, -- improve searching using '/'
  smartindent = true, -- smarter indentation
  smarttab = true, -- make tab behaviour smarter
  splitbelow = true, -- split below instead of above
  splitright = true, -- split right instead of left
  startofline = false, -- don't go to the start of the line when moving to another file
  swapfile = false, -- disable swapfile
  termguicolors = true, -- truecolours for better experience
  wrap = false, -- dont wrap lines
  writebackup = false, -- disable backup

  backupcopy = "yes", -- fix weirdness for postcss
  completeopt = 'menu,menuone,noinsert,noselect', -- better completion
  encoding = "UTF-8", -- set encoding
  fillchars = "vert:│,eob:\\ ", -- make vertical split sign better
  foldmethod = "marker", -- foldmethod using marker
  inccommand = "split", -- incrementally show result of command
  listchars = "eol:↲,tab:»\\ ", -- set listchars
  mouse = "a", -- enable mouse support
  shortmess = "csa", -- disable some stuff on shortmess
  signcolumn = "yes", -- enable sign column all the time, 4 column

  colorcolumn = 80, -- 80 chars color column
  laststatus = 2, -- always enable statusline
  cmdheight = 2, -- number of screen lines to use for the command-line
  pumheight = 10, -- limit completion items
  re = 0, -- set regexp engine to auto
  scrolloff = 2, -- make scrolling better
  shiftwidth = 4, -- set indentation width
  sidescroll = 2, -- make scrolling better
  sidescrolloff = 15, -- make scrolling better
  synmaxcol = 400, -- set limit for syntax highlighting in a single line
  tabstop = 4, -- tabsize
  timeoutlen = 450, -- faster timeout wait time
  updatetime = 100, -- set faster update time
}

apply_options(options)
