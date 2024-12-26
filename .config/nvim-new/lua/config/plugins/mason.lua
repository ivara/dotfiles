return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				}
			})
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require('mason-lspconfig').setup({
				ensure_installed = { 'lua_ls', 'csharp_ls' }
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()

			-- local capabilities = require('blink.cmp').get_lsp_capabilities()
			local lspconfig = require('lspconfig')

			-- C#
			lspconfig.csharp_ls.setup{}

			-- Lua
			lspconfig.lua_ls.setup{
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' },  -- Ensure 'vim' is recognized as a global variable
						},
					}
				}
			}
		end
	}
}
