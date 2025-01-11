-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.number = true
vim.opt.relativenumber = true

-- enable 24bit colors
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes:1"

-- how many commands to remember
vim.opt.history = 200

vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true

-- when splitting, put cursor in the new split
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.wildmenu = true
-- vim.opt.wildmode = "longest, full"

vim.opt.scrolloff = 5

-- Make tab completion case-insensitive
vim.opt.wildignorecase = true


vim.opt.showmode = false

-- Custom keymaps
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Move lines with ALT-j/k
-- using mini.move instead
-- vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv")
-- vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv")
-- vim.keymap.set('n', '<M-j>', ":m .+1<CR>==")
-- vim.keymap.set('n', '<M-k>', ":m .-2<CR>==")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
	vim.highlight.on_yank()
  end,
})



-- Load Lazy plugin manage
require("config.lazy")

