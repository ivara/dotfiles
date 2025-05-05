if true then return {} end

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},

		config = function()
			require('neo-tree').setup({
				filesystem = {
					follow_current_file = { enabled = true },
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_by_name = {
							"node_modules",
							".git",
							".svelte-kit"
						},
						hide_by_pattern = {
							"**/bin",
							"**/obj"
						}
					}

				},
				window = {
					focus_on_open = true,
					position = "left",
					auto_preview = true,
					width = 50
				},
				source_selector = {
					winbar = true,
					statusline = false
				},

				-- default_component_configs = {
				--   container = {
				-- 	enable_character_fade = true
				--   },
				--   icon = {
				-- 	folder_closed = "",
				-- 	folder_open = "",
				-- 	folder_empty = "󰜌",
				-- 	provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
				-- 	  if node.type == "file" or node.type == "terminal" then
				-- 		local success, web_devicons = pcall(require, "nvim-web-devicons")
				-- 		local name = node.type == "terminal" and "terminal" or node.name
				-- 		if success then
				-- 		  local devicon, hl = web_devicons.get_icon(name)
				-- 		  icon.text = devicon or icon.text
				-- 		  icon.highlight = hl or icon.highlight
				-- 		end
				-- 	  end
				-- 	end,
				-- 	-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- 	-- then these will never be used.
				-- 	default = "*",
				-- 	highlight = "NeoTreeFileIcon"
				--   },
				--   modified = {
				-- 	symbol = "[+]",
				-- 	highlight = "NeoTreeModified",
				--   },
				--   name = {
				-- 	trailing_slash = false,
				-- 	use_git_status_colors = true,
				-- 	highlight = "NeoTreeFileName",
				--   },
				-- 	 git_status = {
				-- 	symbols = {
				-- 	  -- Change type
				-- 	  added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				-- 	  modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
				-- 	  deleted   = "✖",-- this can only be used in the git_status source
				-- 	  renamed   = "󰁕",-- this can only be used in the git_status source
				-- 	  -- Status type
				-- 	  untracked = "",
				-- 	  ignored   = "",
				-- 	  unstaged  = "󰄱",
				-- 	  staged    = "",
				-- 	  conflict  = "",
				-- 	}
				-- 	 },
				-- }
			})

			vim.keymap.set('n', '<leader>E', '<cmd>Neotree toggle float reveal<CR>', { noremap = true, silent = true })
			vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle reveal left<CR>', { noremap = true, silent = true })
			-- vim.keymap.set('n', '<leader>b', '<cmd>Neotree toggle show buffers right <CR>', { noremap = true, silent = true })
			vim.keymap.set('n', '<leader>gs', '<cmd>Neotree float git_status <CR>', { noremap = true, silent = true })
			-- vim.keymap.set('n', '<leader>b', '<cmd>Neotree action=show source=buffers position=bottom toggle=true <CR>', { noremap = true, silent = true })

			vim.keymap.set('n', '-', function()
					local reveal_file = vim.fn.expand('%:p')
					if (reveal_file == '') then
						reveal_file = vim.fn.getcwd()
					else
						local f = io.open(reveal_file, "r")
						if (f) then
							f.close(f)
						else
							reveal_file = vim.fn.getcwd()
						end
					end
					require('neo-tree.command').execute({
						action = "focus",    -- OPTIONAL, this is the default value
						source = "filesystem", -- OPTIONAL, this is the default value
						position = "float",  -- OPTIONAL, this is the default value
						reveal_file = reveal_file, -- path to file or folder to reveal
						reveal_force_cwd = true, -- change cwd without asking if needed
					})
				end,
				{ desc = "Open neo-tree at current file or working directory" }
			);
		end
	}
}
