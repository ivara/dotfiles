-- Bicep Language Server (Azure)
-- https://github.com/Azure/bicep
return {
  cmd = { vim.fn.stdpath('data') .. '/mason/bin/bicep-lsp' },
  filetypes = { 'bicep' },
  root_markers = { 'bicepconfig.json', '.git' },
}
