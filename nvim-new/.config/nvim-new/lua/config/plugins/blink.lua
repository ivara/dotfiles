return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
	  preset = 'default',
	  ['<C-.>'] = { function(cmp) cmp.show() end }
	},

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { "sources.default" }
}

-- return {
--   "saghen/blink.cmp",
--   dependencies = "rafamadriz/friendly-snippets",
--   version = '*',
--   opts = {
-- 	keymap = { preset = "default" },
-- 	appearance = {
-- 	  use_nvim_cmp_as_default = true,
-- 	  nerd_font_variant = "mono"
-- 	},
-- 	signature = { enabled = true }
--   }
-- }
--

-- return {
  --   -- enabled = false,
  --   'saghen/blink.cmp',
  --   lazy = false,
  --   -- optional: provides snippets for the snippet source
  --   dependencies = 'rafamadriz/friendly-snippets',
  --
  --   -- use a release tag to download pre-built binaries
  --   version = '*',
  --   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  --   -- build = 'cargo build --release',
  --   -- If you use nix, you can build from source using latest nightly rust with:
  --   -- build = 'nix run .#build-plugin',
  --
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = {
	-- 	-- 'default' for mappings similar to built-in completion
	-- 	-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
	-- 	-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
	-- 	-- See the full "keymap" documentation for information on defining your own keymap.
	-- 	-- keymap = { preset = 'default' },
	-- 	keymap = {
	  -- 	  preset = 'default'
	  -- 	},
	  --
	  -- 	appearance = {
		-- 	  -- Sets the fallback highlight groups to nvim-cmp's highlight groups
		-- 	  -- Useful for when your theme doesn't support blink.cmp
		-- 	  -- Will be removed in a future release
		-- 	  use_nvim_cmp_as_default = true,
		-- 	  -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- 	  -- Adjusts spacing to ensure icons are aligned
		-- 	  nerd_font_variant = 'mono'
		-- 	},
		--
		-- 	-- Default list of enabled providers defined so that you can extend it
		-- 	-- elsewhere in your config, without redefining it, due to `opts_extend`
		-- 	sources = {
		  -- 	  default = { 'lsp', 'path', 'buffer' },
		  -- 	},
		  -- 	signature = { enabled = true },
		  -- 	completion = {
			-- 	  trigger = {
			  -- 		prefetch_on_insert = true
			  -- 	  },
			  -- 	  ghost_text = { enabled = true },
			  -- 	  documentation = {
				-- 		auto_show = true,
				-- 		auto_show_delay_ms = 200,
				-- 	  },
				-- 	  menu = {
				  -- 		border = 'single',
				  -- 		draw = {
					-- 		  components = {
					  -- 			kind_icon = {
						-- 			  ellipsis = false,
						-- 			  text = function(ctx)
						  -- 				local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
						  -- 				return kind_icon
						  -- 			  end,
						  -- 			  -- Optionally, you may also use the highlights from mini.icons
						  -- 			  highlight = function(ctx)
							-- 				local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
							-- 				return hl
							-- 			  end,
							-- 			}
							-- 		  }
							-- 		}
							--
							--
							-- 	  }
							-- 	},
							--   },
							--   opts_extend = { "sources.default" }
							-- }
