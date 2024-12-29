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
		ensure_installed = {
		  'lua_ls',
		  -- 'omnisharp', -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#omnisharp
		  'csharp_ls'
		}
	  })
	end
  },
  {
	"neovim/nvim-lspconfig",
	dependencies = {
	  'saghen/blink.cmp',
	  {
		"folke/lazydev.nvim",
		opts = {
		  library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } }
		  }
		}
	  }
	},
	config = function()

	  local capabilities = require('blink.cmp').get_lsp_capabilities()
	  local lspconfig = require('lspconfig')

	  -- C#
	  --  lspconfig.omnisharp.setup(
		-- { 
		  --   -- cmd = { "dotnet" }
		  --  cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
		  -- })
		  lspconfig.csharp_ls.setup({ capabilities = capabilities })
		  --
		  --  lspconfig.omnisharp.setup({
			-- capabilities = capabilities,
			-- cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
			-- enable_import_completion = true,
			-- organize_imports_on_format = true,
			-- enable_roslyn_analyzers = true,
			-- root_dir = function ()
			  --   return vim.loop.cwd() -- current working directory
			  -- end,
			  --  })

			  -- Lua
			  lspconfig.lua_ls.setup({
				settings = {
				  Lua = {
					diagnostics = {
					  globals = { 'vim' },  -- Ensure 'vim' is recognized as a global variable
					},
				  }
				}
			  })
			end
		  }
		}
