-- nvim-treesitter for Neovim 0.11+
-- New API: no more configs.setup, highlighting via vim.treesitter.start()
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- Install parsers (async, no-op if already installed)
      require('nvim-treesitter').install({
        'c',
        'c_sharp',
        'lua',
        'vim',
        'vimdoc',
        'query',
        'markdown',
        'markdown_inline',
        'go',
        'rust',
        'python',
        'typescript',
        'javascript',
        'json',
        'yaml',
        'bash',
        'html',
        'css',
      })
    end,
  },
}
