-- JSON Language Server
-- https://github.com/microsoft/vscode-json-languageservice
-- Note: Uses schemastore.nvim for schema catalog (loaded lazily)
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { '.git' },
  init_options = {
    provideFormatter = true,
  },
  on_attach = function()
    -- Dynamically configure schemas when attached
    local ok, schemastore = pcall(require, 'schemastore')
    if ok then
      vim.lsp.config.jsonls.settings = {
        json = {
          schemas = schemastore.json.schemas(),
          validate = { enable = true },
        },
      }
    end
  end,
  settings = {
    json = {
      validate = { enable = true },
    },
  },
}
