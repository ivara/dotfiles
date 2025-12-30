-- Neovim 0.12 Configuration
-- Using native LSP (no nvim-lspconfig required)

--------------------------------------------------------------------------------
-- Leader keys (must be set before lazy.nvim)
--------------------------------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

--------------------------------------------------------------------------------
-- General Options
--------------------------------------------------------------------------------
-- Persistence
vim.opt.undofile = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Display
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes:1'
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.scrolloff = 5

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Command line
vim.opt.history = 200
vim.opt.wildmenu = true
vim.opt.wildignorecase = true

--------------------------------------------------------------------------------
-- Neovim 0.12 Specific Options
--------------------------------------------------------------------------------
-- Popup menu border
-- vim.o.pumborder = true

-- Auto-completion (triggers on CursorHoldI, respects updatetime)
-- vim.o.autocomplete = 'menu'

-- Completion options
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'fuzzy' }

--------------------------------------------------------------------------------
-- Diagnostics Configuration
--------------------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
  },
})

--------------------------------------------------------------------------------
-- Filetype Detection
--------------------------------------------------------------------------------
vim.filetype.add({
  extension = {
    bicep = 'bicep',
  },
})

--------------------------------------------------------------------------------
-- LSP Configuration (Native Neovim 0.11+)
--------------------------------------------------------------------------------
-- Enable LSP servers (configs are in lsp/ directory)
vim.lsp.enable({
  'lua_ls',
  'gopls',
  'rust_analyzer',
  'ts_ls',
  'bicep',
  'pyright',
  'yamlls',
  'jsonls',
})

-- LspAttach autocmd for keymaps and features
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

    -- Helper for buffer-local keymaps
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Go to definitions (some are built-in defaults in 0.12, but explicit is clearer)
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('n', 'gr', vim.lsp.buf.references, 'References')
    map('n', 'gI', vim.lsp.buf.implementation, 'Implementation')
    -- grt is already default in 0.12 for type_definition

    -- Hover and signature
    map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
    map('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')

    -- Code actions (<leader>c)
    map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('v', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename')
    map('n', '<leader>cf', function()
      vim.lsp.buf.format({ async = true })
    end, 'Format')
    map('n', '<leader>cl', '<cmd>lsp<cr>', 'LSP info (0.12)')

    -- Diagnostics (<leader>d)
    map('n', '<leader>dd', vim.diagnostic.open_float, 'Line diagnostics')
    map('n', '<leader>dq', vim.diagnostic.setqflist, 'Quickfix list')
    map('n', '<leader>dl', vim.diagnostic.setloclist, 'Location list')
    map('n', ']d', function()
      vim.diagnostic.jump({ count = 1 })
    end, 'Next diagnostic')
    map('n', '[d', function()
      vim.diagnostic.jump({ count = -1 })
    end, 'Previous diagnostic')

    -- Enable inlay hints if supported
    if client and client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Enable inline completion for all servers (0.12 experimental)
    if client and client:supports_method('textDocument/inlineCompletion') then
      vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
      })
    end
  end,
})

--------------------------------------------------------------------------------
-- General Keymaps
--------------------------------------------------------------------------------
-- Escape insert mode
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- UI toggles (<leader>u)
vim.keymap.set('n', '<leader>uh', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' })

-- Undotree (built-in in 0.12!)
vim.keymap.set('n', '<leader>uu', '<cmd>Undotree<cr>', { desc = 'Undo tree' })

-- Better window navigation (if not using vim-tmux-navigator)
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Clear search highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })

-- Better indenting (stay in visual mode)
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

-- Quickfix navigation
vim.keymap.set('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Open quickfix' })
vim.keymap.set('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Open location list' })
vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { desc = 'Next quickfix' })
vim.keymap.set('n', '[q', '<cmd>cprev<cr>', { desc = 'Previous quickfix' })

--------------------------------------------------------------------------------
-- Autocommands
--------------------------------------------------------------------------------
-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Resize splits when window is resized
vim.api.nvim_create_autocmd('VimResized', {
  group = vim.api.nvim_create_augroup('resize-splits', { clear = true }),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('last-location', { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

--------------------------------------------------------------------------------
-- Load Lazy Plugin Manager
--------------------------------------------------------------------------------
require('config.lazy')
