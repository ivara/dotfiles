local map = vim.api.nvim_set_keymap

-- Disable the spacebar key's default behavior in Normal and Visual modes
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Toggle between tabs
-- map("n", "<C-h>", "<C-w>h", { noremap = true, silent = false })
-- map("n", "<C-j>", "<C-w>j", { noremap = true, silent = false })
-- map("n", "<C-k>", "<C-w>k", { noremap = true, silent = false })
-- map("n", "<C-l>", "<C-w>l", { noremap = true, silent = false })

-- BufferLine
-- map("n", "<Tab>", ":BufferLineCycleNext<cr>", { noremap = true, silent = true })
-- map("n", "<S-Tab>", ":BufferLineCyclePrev<cr>", { noremap = true, silent = true })

-- Vertical scroll and center
-- vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
-- vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)
--
-- Indenting
-- map("v", "<", "<gv", { noremap = true, silent = false })
-- map("v", ">", ">gv", { noremap = true, silent = false })
--
-- Copy-Pasting
-- map("v", "<C-c>", '"+y', { noremap = true, silent = false })
-- map("n", "<C-s>", '"+P', { noremap = true, silent = false })

-- Remapping Escape key
map("i", "jk", "<Esc>", { noremap = true, silent = false })

-- Unhighlight searched elements
-- map("n", "<C-u>", ":nohlsearch<cr>", { noremap = true, silent = true })
--

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
-- vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
-- vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
-- vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
-- vim.keymap.set('n', 'x', '"_x', opts)
--
-- -- Vertical scroll and center
-- vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
-- vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)
--
-- -- Find and center
-- vim.keymap.set('n', 'n', 'nzzzv', opts)
-- vim.keymap.set('n', 'N', 'Nzzzv', opts)
--
-- -- Resize with arrows
-- vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
-- vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
-- vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
-- vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)
--
-- -- Buffers
-- vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
-- vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
-- vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts) -- close buffer
-- vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer
--
-- -- Toggle line wrapping
-- vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)
--
-- -- Stay in indent mode
-- vim.keymap.set('v', '<', '<gv', opts)
-- vim.keymap.set('v', '>', '>gv', opts)
--
-- -- Keep last yanked when pasting
-- vim.keymap.set('v', 'p', '"_dP', opts)
--
-- -- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
