return {
  -- lazy.nvim
  {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	-- couldn't figure out how to Toggle so uhe/uhd will do for now
	keys = {
	  {
		"<leader>uhe",
		function()
		  vim.cmd("Hardtime enable")
		  vim.notify("Hardtime enabled", vim.log.levels.INFO)
		end,
		desc = "[H]ardtime [e]nable"
	  },
	  {
		"<leader>uhd",
		function()
		  vim.cmd("Hardtime disable")
		  vim.notify("Hardtime disabled", vim.log.levels.WARN)
		end,
		desc = "[H]ardtime [d]isable"}
	  },
	  opts = {
		-- Add "oil" to the disabled_filetypes
		disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" }
	  }
	},
  }
