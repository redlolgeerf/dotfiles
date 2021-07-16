local snap = require'snap'

--local fzy = snap.get'consumer.fzy'
local limit = snap.get'consumer.limit'
local producer_file = snap.get'producer.ripgrep.file'
local producer_vimgrep = snap.get'producer.ripgrep.vimgrep'
local producer_buffer = snap.get'producer.vim.buffer'
local producer_currentbuffer = snap.get'producer.vim.currentbuffer'
local select_file = snap.get'select.file'
local select_vimgrep = snap.get'select.vimgrep'
local preview_file = snap.get'preview.file'
local preview_vimgrep = snap.get'preview.vimgrep'

snap.register.map({'n'}, {'<c-p>'}, function ()
  snap.run({
    prompt = 'Files',
    --producer = fzy(producer_file),
	producer = snap.get'consumer.fzy'(producer_file),
    select = select_file.select,
    multiselect = select_file.multiselect,
    views = {preview_file}
  })
end)

snap.register.map({'n'}, {'<Leader>g'}, function ()
  snap.run({
	prompt = 'Grep',
	producer = limit(10000, producer_vimgrep),
	select = select_vimgrep.select,
	multiselect = select_vimgrep.multiselect,
	views = {preview_vimgrep}
  })
end)

snap.register.map({'n'}, {'gb'}, function ()
  snap.run({
	prompt = 'Buffers',
	--producer = fzy(producer_buffer),
	producer = snap.get'consumer.fzy'(producer_buffer),
	select = select_file.select,
	multiselect = select_file.multiselect,
	views = {preview_file}
  })
end)

snap.register.map({'n'}, {'<Leader>f'}, function ()
  snap.run({
	prompt = 'Grep',
	producer = limit(10000, producer_vimgrep),
	select = select_vimgrep.select,
	multiselect = select_vimgrep.multiselect,
	initial_filter = vim.fn.expand('<cword>')
  })
end)
