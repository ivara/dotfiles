return {

	{
		"Issafalcon/neotest-dotnet", 
		commit="184f9f5c5e39b87025eebbbeed7736200338377c"
	},

	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-dotnet")({})
				}
			})

			-- require("neotest").setup({
				-- 	adapters = {
					-- 		require("neotest-dotnet")
					-- 	}
					-- })
				end
			}
		}
