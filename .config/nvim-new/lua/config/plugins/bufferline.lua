return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		require('bufferline').setup({
			options = {
				offsets = { { filetype = "NvimTree", text = "File Explorer", padding = 1 } },
				numbers = "none", -- Show numbers in tabs (can be "none", "ordinal", or "buffer_id")
				close_command = "bdelete! %d", -- Command to close a buffer
				right_mouse_command = "bdelete! %d", -- Right-click command to close a buffer
				show_buffer_icons = true, -- Show icons in the bufferline
				show_buffer_close_icons = true, -- Show close icons in the bufferline
				show_tab_indicators = true, -- Show tab indicators
				separator_style = "thick", -- Set the separator style to slanted
				always_show_bufferline = true, -- Always show the bufferline
			},

		})

		-- Navigate to buffer 1, 2, 3, etc., using leader followed by numbers
		vim.api.nvim_set_keymap('n', '<Leader>1', ':BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>2', ':BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>3', ':BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>4', ':BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>5', ':BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>6', ':BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>7', ':BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>8', ':BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<Leader>9', ':BufferLineGoToBuffer 9<CR>', { noremap = true, silent = true })
	end
}

