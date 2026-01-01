-- nvim-treesitter for Neovim 0.11+
-- New API: highlighting via vim.treesitter.start() (in init.lua)
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
    -- build = function()
    --   -- Only runs on install/update, not every startup
    --   require('nvim-treesitter').install({
    --     'c',
    --     'c_sharp',
    --     'lua',
    --     'vim',
    --     'vimdoc',
    --     'query',
    --     'markdown',
    --     'markdown_inline',
    --     'go',
    --     'rust',
    --     'python',
    --     'typescript',
    --     'javascript',
    --     'json',
    --     'yaml',
    --     'bash',
    --     'html',
    --     'css',
    --   })
    -- end,
  },
}
