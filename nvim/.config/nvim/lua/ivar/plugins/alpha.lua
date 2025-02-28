-- if true then return {} end
return {
    'goolord/alpha-nvim',
    dependencies = {
        'echasnovski/mini.icons',
        'nvim-lua/plenary.nvim'
    },
    config = function ()
        require'alpha'.setup(require'alpha.themes.theta'.config)
    end
};

-- return {
--     'goolord/alpha-nvim',
--     config = function ()
--         require'alpha'.setup(require'alpha.themes.dashboard'.config)
--     end
-- };

-- return {
-- 	'goolord/alpha-nvim',
-- 	dependencies = { 'nvim-tree/nvim-web-devicons' },
-- 	config = function ()
-- 		require'alpha'.setup(require'alpha.themes.dashbord'.config)
-- 	end
-- }
