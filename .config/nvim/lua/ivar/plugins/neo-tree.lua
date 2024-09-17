return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },

    keys = {
        { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
        filesystem = {
            window = {
                mappings = {
                    ['\\'] = 'close_window',
                },
            },
        },
        window = {
            mappings = {
                ["l"] = "open",
                ["h"] = "close_node",
                ["<space>"] = "none"
            }
        },
        default_component_configs = {
            indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            git_status = {
                symbols = {
                    unstaged = "󰄱",
                    staged = "󰱒",
                },
            },
        },
    }
}
-- return {
--   'nvim-neo-tree/neo-tree.nvim',
--   version = '*',
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
--     'MunifTanjim/nui.nvim',
--   },
--   cmd = 'Neotree',
--   keys = {
--     { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
--   },
--   opts = {
--     filesystem = {
--       window = {
--         mappings = {
--           ['\\'] = 'close_window',
--         },
--       },
--     },
--   },
-- }
--
