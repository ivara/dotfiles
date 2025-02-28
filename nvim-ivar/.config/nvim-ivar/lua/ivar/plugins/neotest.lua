return {
	-- { "Issafalcon/neotest-dotnet" },
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"Issafalcon/neotest-dotnet",
		},
		opts = {
			adapters = { "neotest-dotnet" },
			-- config = function()
			-- 	require("neotest").setup({
			-- 		adapters = {
			-- 			require("neotest-dotnet")
			-- 		}
			-- 	})
			-- end,
		},
	},
}
