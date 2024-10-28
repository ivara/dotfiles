-- if true then return {} end
return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
   -- 'echasnovski/mini.icons',
    'nvim-lua/plenary.nvim'
  },
  config = function ()
    local alpha = require('alpha')
    -- local dashboard = require('alpha.themes.startify')
    local dashboard = require('alpha.themes.dashboard')

    -- require'alpha'.setup(require'alpha.themes.theta'.config)
    -- -- Define a custom button for selecting Neovim configurations
    -- dashboard.section.buttons.val = {
    --   dashboard.button("c", "  Configurations", ":lua require('telescope.builtin').find_files({ prompt_title = 'Neovim Configs', cwd = '~/.config/nvim', search_dirs = { '~/.config/nvim' }, hidden = true })<CR>"),
    --   dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    --   dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
    -- }

    -- Set the header
    -- dashboard.section.header.val = {
    --   "Welcome to Neovim",
    -- }
    --
    -- -- Set the footer
    -- dashboard.section.footer.val = {
    --   "Press 'c' to select a configuration",
    -- }
    --
    -- Apply the configuration
    alpha.setup(dashboard.config)
  end
};

-- return {
--     'goolord/alpha-nvim',
--     config = function ()
--         require'alpha'.setup(require'alpha.themes.dashboard'.config)
--     end
-- };
--
