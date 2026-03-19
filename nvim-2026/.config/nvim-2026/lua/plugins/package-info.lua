return {
  "vuki656/package-info.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  -- Only load when a package.json file is opened
  event = { "BufReadPre package.json", "BufNewFile package.json" },
  -- opts = {
  --   -- highlights = {
  --   --   up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
  --   --   outdated = "#d19a66", -- Text color for outdated dependency virtual text
  --   --   invalid = "#ee4b2b", -- Text color for invalid dependency virtual text
  --   -- },
  --   icons = {
  --     enable = true, -- Whether to display icons
  --     style = {
  --       up_to_date = "|  ", -- Icon for up to date dependencies
  --       outdated = "|  ", -- Icon for outdated dependencies
  --       invalid = "|  ", -- Icon for invalid dependencies
  --     },
  --   },
  -- },
  config = function(_, opts)
    require("package-info").setup(opts)

    -- manually register them
    -- vim.cmd([[highlight PackageInfoInvalidVersion guifg=]] .. opts.highlights.invalid)
    -- vim.cmd([[highlight PackageInfoUpToDateVersion guifg=]] .. opts.highlights.up_to_date)
    -- vim.cmd([[highlight PackageInfoOutdatedVersion guifg=]] .. opts.highlights.outdated)
    --
    -- Show dependency versions
    vim.keymap.set(
      { "n" },
      "<LEADER>ns",
      require("package-info").show,
      { silent = true, noremap = true, desc = "Show package info" }
    )

    -- Hide dependency versions
    vim.keymap.set(
      { "n" },
      "<LEADER>nc",
      require("package-info").hide,
      { silent = true, noremap = true, desc = "Conceal package info" }
    )

    -- Toggle dependency versions
    vim.keymap.set(
      { "n" },
      "<LEADER>nt",
      require("package-info").toggle,
      { silent = true, noremap = true, desc = "Toggle package info" }
    )

    -- Update dependency on the line
    vim.keymap.set(
      { "n" },
      "<LEADER>nu",
      require("package-info").update,
      { silent = true, noremap = true, desc = "Update package" }
    )

    -- Delete dependency on the line
    vim.keymap.set(
      { "n" },
      "<LEADER>nd",
      require("package-info").delete,
      { silent = true, noremap = true, desc = "Delete package" }
    )

    -- Install a new dependency
    vim.keymap.set(
      { "n" },
      "<LEADER>ni",
      require("package-info").install,
      { silent = true, noremap = true, desc = "Install package" }
    )

    -- Install a different dependency version
    vim.keymap.set(
      { "n" },
      "<LEADER>np",
      require("package-info").change_version,
      { silent = true, noremap = true, desc = "Change package version" }
    )
  end,
}
