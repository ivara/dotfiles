-- which-key: Keybinding discovery
-- https://github.com/folke/which-key.nvim
return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'modern',
      delay = 300,
      icons = {
        breadcrumb = '',
        separator = '',
        group = ' ',
      },
      spec = {
        { '<leader>f', group = 'find' },
        { '<leader>g', group = 'git' },
        { '<leader>c', group = 'code' },
        { '<leader>d', group = 'diagnostics' },
        { '<leader>u', group = 'ui/toggle' },
        { '<leader>x', group = 'quickfix' },
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer local keymaps',
      },
    },
  },
}
