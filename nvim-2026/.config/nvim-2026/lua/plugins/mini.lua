-- Mini.nvim modules
-- https://github.com/echasnovski/mini.nvim
return {
  {
    'echasnovski/mini.nvim',
    version = false,
    event = 'VeryLazy',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- for git branch and diff info in statusline
    },
    config = function()
      -- Icons: icon provider for other mini modules
      require('mini.icons').setup()
      MiniIcons.tweak_lsp_kind() -- Show icons in completion menu instead of text

      -- Statusline: minimal and fast statusline
      require('mini.statusline').setup({
        use_icons = true,
      })

      -- Tabline: show buffers at the top
      require('mini.tabline').setup({
        show_icons = true,
        tabpage_section = 'right',
      })

      -- Cmdline: autocomplete, autocorrect, and range preview
      require('mini.cmdline').setup()

      -- Cursorword: highlight word under cursor
      require('mini.cursorword').setup()

      -- Pairs: auto-close brackets, quotes, etc.
      require('mini.pairs').setup()

      -- Snippets: lightweight snippet support
      require('mini.snippets').setup()
      MiniSnippets.start_lsp_server() -- Show snippets in completion menu

      -- Completion: lightweight LSP completion with auto-popup
      require('mini.completion').setup({
        -- Delay before showing completion (ms)
        delay = { completion = 100, info = 100, signature = 50 },
        window = {
          info = { border = 'rounded' },
          signature = { border = 'rounded' },
        },
      })

      -- Files: file explorer with Miller columns
      require('mini.files').setup({
        windows = {
          preview = true,
        },
      })

      vim.keymap.set('n', '<leader>e', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      end, { desc = 'Open file explorer' })

      -- Buffer navigation
      vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
      vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
    end,
  },
}
