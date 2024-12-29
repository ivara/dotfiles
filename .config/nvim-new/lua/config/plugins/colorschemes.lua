return {
  {
	"catppuccin/nvim", -- https://github.com/catppuccin/nvim
	name = "catppuccin",
	priority = 1000,
	config = function()
	  -- There is no need to call setup if you don't want to change the default options and settings.
	  -- setup must be called before loading
	  vim.cmd.colorscheme "catppuccin"
	end
  },
  {
	"folke/tokyonight.nvim",
	-- config = function()
	--   vim.cmd.colorscheme "tokyonight"
	-- end
  },
  { "rebelot/kanagawa.nvim", lazy = false },
}
