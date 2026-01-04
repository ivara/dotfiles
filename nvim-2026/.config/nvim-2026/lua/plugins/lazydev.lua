-- lazydev.nvim: Proper Lua LSP setup for Neovim config development
-- https://github.com/folke/lazydev.nvim
return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- Load the wezterm types when the `wezterm` module is required
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },
}
