-- Colorschemes
return {
  -- Kanagawa
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    -- config = function()
    --   require('kanagawa').setup({
    --     compile = true,
    --     undercurl = true,
    --     commentStyle = { italic = true },
    --     functionStyle = {},
    --     keywordStyle = { italic = true },
    --     statementStyle = { bold = true },
    --     typeStyle = {},
    --     transparent = false,
    --     dimInactive = false,
    --     terminalColors = true,
    --     colors = {
    --       theme = {
    --         all = {
    --           ui = {
    --             bg_gutter = 'none',
    --           },
    --         },
    --       },
    --     },
    --     overrides = function(colors)
    --       local theme = colors.theme
    --       return {
    --         -- Rounded borders for floating windows
    --         NormalFloat = { bg = theme.ui.bg_p1 },
    --         FloatBorder = { bg = theme.ui.bg_p1 },
    --         FloatTitle = { bg = theme.ui.bg_p1 },
    --         -- Popup menu
    --         Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
    --         PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
    --         PmenuSbar = { bg = theme.ui.bg_m1 },
    --         PmenuThumb = { bg = theme.ui.bg_p2 },
    --       }
    --     end,
    --   })
    --   vim.cmd.colorscheme('kanagawa')
    -- end,
  },
  -- Catppuccin (primary)
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
  },
}
