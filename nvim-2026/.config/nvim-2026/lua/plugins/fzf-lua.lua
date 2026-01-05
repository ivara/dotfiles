-- fzf-lua: Fast fuzzy finder
-- https://github.com/ibhagwan/fzf-lua
return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
      -- Find
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
      { "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor" },
      { "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>", desc = "Grep WORD under cursor" },
      { "<leader>f/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Grep current buffer" },
      { "<leader>fq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix list" },
      { "<C-p>", "<cmd>FzfLua files<cr>", desc = "Find files" },

      -- Find config/neovim files
      {
        "<leader>fc",
        function()
          require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find config files",
      },
      {
        "<leader>fn",
        function()
          require("fzf-lua").files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
        end,
        desc = "Find Neovim plugin files",
      },

      -- LSP
      { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>fS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
      { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
      { "<leader>fD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },

      -- Git
      { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
      { "<leader>gC", "<cmd>FzfLua git_bcommits<cr>", desc = "Git buffer commits" },
      { "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Git branches" },
      { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
      { "<leader>gS", "<cmd>FzfLua git_stash<cr>", desc = "Git stash" },

      -- UI
      { "<leader>uc", "<cmd>FzfLua colorschemes<cr>", desc = "Colorschemes" },
      { "<leader>uk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
      { "<leader>uo", "<cmd>FzfLua nvim_options<cr>", desc = "Vim options" },

      -- Misc
      { "<leader>f:", "<cmd>FzfLua command_history<cr>", desc = "Command history" },
      { '<leader>f"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
    },
    opts = {
      -- Use telescope profile for familiar UI
      "telescope",
      winopts = {
        border = "rounded",
        width = 0.95,
        preview = {
          layout = "horizontal",
          horizontal = "right:55%",
        },
      },
      files = {
        hidden = true,
        follow = true,
      },
      grep = {
        hidden = true,
      },
      -- lsp = {
      --   symbols = {
      --     symbol_icons = {
      --       File = '',
      --       Module = '',
      --       Namespace = '',
      --       Package = '',
      --       Class = '',
      --       Method = '',
      --       Property = '',
      --       Field = '',
      --       Constructor = '',
      --       Enum = '',
      --       Interface = '',
      --       Function = '',
      --       Variable = '',
      --       Constant = '',
      --       String = '',
      --       Number = '',
      --       Boolean = '',
      --       Array = '',
      --       Object = '',
      --       Key = '',
      --       Null = '',
      --       EnumMember = '',
      --       Struct = '',
      --       Event = '',
      --       Operator = '',
      --       TypeParameter = '',
      --     },
      --   },
      -- },
    },
  },
}
