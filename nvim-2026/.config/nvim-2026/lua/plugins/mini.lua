-- Mini.nvim modules
-- https://github.com/echasnovski/mini.nvim
return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- for git branch and diff info in statusline
    },
    config = function()
      -- Icons: icon provider for other mini modules
      require("mini.icons").setup()

      -- Statusline: minimal and fast statusline with macro recording indicator
      require("mini.statusline").setup({
        use_icons = true,
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 40 })
            local diff = MiniStatusline.section_diff({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location = MiniStatusline.section_location({ trunc_width = 75 })
            local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

            -- Macro recording indicator (shown in orange/warning color)
            local recording = vim.fn.reg_recording()
            local macro = recording ~= "" and ("Recording @" .. recording) or ""

            return MiniStatusline.combine_groups({
              { hl = mode_hl, strings = { mode } },
              { hl = "WarningMsg", strings = { macro } },
              { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
              "%<", -- Mark general truncate point
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=", -- End left alignment
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { hl = mode_hl, strings = { search, location } },
            })
          end,
        },
      })

      -- Tabline: show buffers at the top
      require("mini.tabline").setup({
        show_icons = true,
        tabpage_section = "right",
      })

      -- Cmdline: autocomplete, autocorrect, and range preview
      require("mini.cmdline").setup()

      -- Cursorword: highlight word under cursor
      require("mini.cursorword").setup()

      -- Pairs: auto-close brackets, quotes, etc.
      require("mini.pairs").setup()

      -- Files: file explorer with Miller columns
      require("mini.files").setup({
        windows = {
          preview = true,
        },
      })

      vim.keymap.set("n", "<leader>e", function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      end, { desc = "📂 explorer" })

      -- Buffer navigation
      vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
      vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

      -- Clue: keybinding discovery (replacement for which-key)
      local miniclue = require("mini.clue")
      miniclue.setup({
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },

          -- Brackets
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },
        },

        clues = {
          -- Enhance with built-in clues
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),

          -- Custom group descriptions
          { mode = "n", keys = "<Leader>f", desc = "🔍 find" },
          { mode = "n", keys = "<Leader>g", desc = "🌿 git" },
          { mode = "n", keys = "<Leader>c", desc = "💻 code" },
          { mode = "n", keys = "<Leader>d", desc = "🩺 diagnostics" },
          { mode = "n", keys = "<Leader>u", desc = "🎨 ui/toggle" },
          { mode = "n", keys = "<Leader>ud", desc = "🩺 diagnostics" },
          { mode = "n", keys = "<Leader>x", desc = "📋 quickfix" },
          { mode = "n", keys = "<Leader>h", desc = "📦 hunk/git" },
          { mode = "x", keys = "<Leader>h", desc = "📦 hunk/git" },
          { mode = "n", keys = "<Leader>b", desc = "📄 buffer" },
          { mode = "n", keys = "<Leader>e", desc = "📂 explorer" },
          { mode = "n", keys = "<Leader>gt", desc = "🔀 toggle" },
        },

        window = {
          delay = 300,
          config = {
            width = "auto",
            border = "rounded",
          },
        },
      })
    end,
  },
}
