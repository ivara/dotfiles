-- YAML Language Server
-- https://github.com/redhat-developer/yaml-language-server
-- Uses schemastore.nvim (Lua plugin) to inject the full SchemaStore catalog.
-- The server's built-in schemaStore fetch is disabled to avoid double-fetching.
return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  root_markers = { '.git' },
  on_init = function(client)
    local ok, schemastore = pcall(require, 'schemastore')
    local catalog_schemas = ok and schemastore.yaml.schemas() or {}

    -- Merge catalog schemas with our custom/override schemas.
    -- Custom schemas are keyed by URL -> glob pattern(s), same as catalog format.
    local custom_schemas = {
      -- Azure Pipelines
      ['https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/main/service-schema.json'] = {
        'azure-pipelines.yml',
        'azure-pipelines.yaml',
        '.azure-pipelines/*.yml',
        '.azure-pipelines/*.yaml',
        'pipelines/*.yml',
        'pipelines/*.yaml',
      },
      -- GitHub Actions / workflows (often already in catalog, but explicit is fine)
      ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
      ['https://json.schemastore.org/github-action.json'] = '/.github/actions/*',
      -- Docker Compose
      ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yml',
    }

    -- Merge: custom_schemas takes precedence over catalog for the same URL
    local merged = vim.tbl_extend('force', catalog_schemas, custom_schemas)

    local settings = {
      yaml = {
        schemaStore = {
          -- Disable server's built-in fetch; we provide schemas from Lua plugin
          enable = false,
          url = '',
        },
        schemas = merged,
        validate = true,
        format = { enable = true },
        hover = true,
        completion = true,
      },
    }

    client.config.settings = vim.tbl_deep_extend('force', client.config.settings or {}, settings)
    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
  end,
  settings = {
    yaml = {
      validate = true,
      format = { enable = true },
      hover = true,
      completion = true,
    },
  },
}
