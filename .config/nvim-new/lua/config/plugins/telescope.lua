return {
  {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
	  'nvim-lua/plenary.nvim',
	  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
	},
	config = function()
	  require('telescope').setup {

		defaults = {
		  layout_config = {
			width = 0.8,           -- File picker width (percentage of screen width, smaller than default)
			height = 0.9,         -- Height of the picker window (adjust as needed)
			preview_width = 0.6,   -- Increase the preview width relative to the picker width (larger preview)
			-- preview_cutoff = 120,  -- Set the cutoff for file preview
			horizontal = {         -- Horizontal layout (file picker on left, preview on right)
			  preview_width = 0.6, -- Adjust the preview width for horizontal layout
			},
			vertical = {           -- Vertical layout (file picker on top, preview on bottom)
			  preview_height = 0.5,-- Adjust the preview height for vertical layout
			},
		  },
		},
		-- For displaying file sizes in the NeoTree window.
		filesystem = {
		  renderers = {
			default = {
			  file = function(node)
				local size = node.stats and node.stats.size or 0
				local size_str = string.format("%dB", size)
				return node.name .. " (" .. size_str .. ")"
			  end
			}
		  }
		},
		-- defaults = {
		  --   -- Set the default window size
		  --   layout_config = {
			-- 	width = 0.85,           -- File picker width (percentage of screen width)
			-- 	height = 0.85,          -- File picker height (percentage of screen height)
			-- 	preview_width = 0.6,    -- Set the preview window width (percentage of file picker width)
			-- 	preview_cutoff = 120,   -- Preview cutoff (if the file is too large, don't show the preview)
			-- 	horizontal = {          -- For horizontal layout (file picker on left, preview on right)
			  -- 	  preview_width = 0.6,  -- Preview width relative to the picker width
			  -- 	},
			  -- 	vertical = {            -- For vertical layout (file picker on top, preview on bottom)
				-- 	  preview_height = 0.5, -- Preview height relative to the picker height
				-- 	},
				--   },
				--
				--   -- Enable preview window, if desired
				--   preview = {
				  -- 	hide_on_startup = false,
				  --   },
				  --
				  --   -- You can further tweak other Telescope settings here
				  -- },
				  pickers = {
					find_files = {
					  -- theme = "ivy"
					},
					colorscheme = {
					  enable_preview = true
					}
				  },
				  extensions = {
					fzf = {}
				  }
				}

				require('telescope').load_extension('fzf')
				local builtin = require('telescope.builtin')

				vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp"})
				vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc  = "[F]ind [F]iles"})
				vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "[F]ind [F]iles"})
				vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
				-- vim.keymap.set('n', '<leader>gc', builtin.git_bcommits, { desc = '[Git] [C]ommits' })
				vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [G]it files' })
				vim.keymap.set("n", "<leader>uc", builtin.colorscheme, { desc = "[U]se [C]olorscheme"})
				vim.keymap.set("n", "<leader>fc", function()
				  builtin.find_files {
					cwd = vim.fn.stdpath("config")
				  }
				end, {desc = "[F]ind [C]onfig"})

				vim.keymap.set("n", "<leader>fn", function()
				  builtin.find_files {
					cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
				  }
				end, { desc = "[F]ind [N]eovim files"})

				-- require "config.telescope.multigrep".setup()
			  end
			},
			{
			  "nvim-telescope/telescope-frecency.nvim",
			  -- install the latest stable version
			  version = "*",
			  config = function()
				require("telescope").load_extension "frecency"
			  end,
			}
		  }
