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
  -- on_init fires before the server is ready to receive settings,
  -- which is the correct hook for injecting dynamic settings like schemas.
  -- on_attach fires after attach but workspace/didChangeConfiguration
  -- is the right mechanism; using on_init + notify is the reliable pattern.
  on_init = function(client)
    local ok, schemastore = pcall(require, 'schemastore')
    if ok then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings or {}, {
        json = {
          schemas = schemastore.json.schemas(),
          validate = { enable = true },
        },
      })
      client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
    end
  end,
  settings = {
    json = {
      validate = { enable = true },
    },
  },
}
