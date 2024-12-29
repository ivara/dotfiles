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

	  vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags, { desc = "[F]ind [H]elp"})
	  vim.keymap.set("n", "<leader>ff", require('telescope.builtin').find_files, { desc  = "[F]ind [F]iles"})
	  vim.keymap.set("n", "<C-p>", require('telescope.builtin').find_files, { desc = "[F]ind [F]iles"})

	  vim.keymap.set("n", "<leader>uc", require('telescope.builtin').colorscheme, { desc = "[U]se [C]olorscheme"})
	  vim.keymap.set("n", "<leader>fc", function()
		require('telescope.builtin').find_files {
		  cwd = vim.fn.stdpath("config")
		}
	  end, {desc = "[F]ind [C]onfig"})

	  vim.keymap.set("n", "<leader>fn", function()
		require('telescope.builtin').find_files {
		  cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
		}
	  end, { desc = "[F]ind [N]eovim files"})

	  -- require "config.telescope.multigrep".setup()
	end
  }
}
