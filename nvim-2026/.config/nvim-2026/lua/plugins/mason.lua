-- Mason: LSP/DAP/Linter/Formatter installer
-- Note: We use native vim.lsp.config() instead of mason-lspconfig
return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = '',
            package_pending = '',
            package_uninstalled = '',
          },
          border = 'rounded',
        },
        -- Custom registries for additional packages (like Roslyn)
        registries = {
          'github:mason-org/mason-registry',
          'github:crashdummyy/mason-registry', -- Roslyn registry
        },
      })
    end,
  },
}
