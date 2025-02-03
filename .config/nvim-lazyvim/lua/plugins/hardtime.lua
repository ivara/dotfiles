return {
  -- lazy.nvim
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("hardtime").setup({
        enabled = true, -- default, but future proof for my toggle
        disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
      })

      local is_enabled = true
      local function enable()
        vim.notify("Hardtime enabled", vim.log.levels.INFO)
        vim.cmd("Hardtime enable")
      end

      local function disable()
        vim.notify("Hardtime disable", vim.log.levels.WARN)
        vim.cmd("Hardtime disable")
      end

      local function toggle()
        if is_enabled == true then
          is_enabled = false
          disable()
        else
          is_enabled = true
          enable()
        end
      end
      -- vim.keymap.set("n", "<leader>uh", toggle, { desc = "Toggle Hardtime"})
      -- vim.keymap.set("n", "<leader>uhe", enable, { desc = "Enable Hardtime"})
      -- vim.keymap.set("n", "<leader>uhd", disable, { desc = "Disable Hardtime"})
    end,
  },
}
