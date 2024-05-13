return {
  { "rebelot/kanagawa.nvim", lazy = false },
  { "ellisonleao/gruvbox.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "shaunsingh/nord.nvim" },
  -- the colorscheme for LazyVim to use as default
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-dragon",
    },
  },
}

-- return {
--   "rebelot/kanagawa.nvim",
--   config = function()
--     vim.cmd.colorscheme("kanagawa-wave")
--   end,
-- }
