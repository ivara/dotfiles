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

      -- Statusline: minimal and fast statusline
      require('mini.statusline').setup({
        use_icons = true,
      })

      -- Tabline: show buffers at the top
      require('mini.tabline').setup({
        show_icons = true,
        tabpage_section = 'right',
      })

      -- Buffer navigation
      vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
      vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
    end,
  },
}
