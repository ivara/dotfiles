-- Mason: LSP/DAP/Linter/Formatter installer
-- Note: We use native vim.lsp.config() instead of mason-lspconfig
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
          border = "rounded",
        },
        -- Custom registries for additional packages (like Roslyn)
        registries = {
          "github:mason-org/mason-registry",
          "github:crashdummyy/mason-registry", -- Roslyn registry
        },
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- LSP servers
          "gopls",
          "lua-language-server",
          "rust-analyzer",
          "typescript-language-server",
          "pyright",
          "yaml-language-server",
          "json-lsp",
          "bicep-lsp",
          "roslyn",

          -- Formatters
          "stylua",
          "gofumpt",
          "prettier",

          -- Linters
          "golangci-lint",
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },
}
