return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      -- python = { "isort", "black" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { "rustfmt", lsp_format = "fallback" },
      -- Conform will run the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      csharp = { "csharpier" },
      -- Go: goimports handles both formatting and import organization
      go = { "goimports", "gofumpt" },
      yaml = { "yamlfmt" },
      bicep = { lsp_format = "prefer" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)

    -- Run ESLint fix-all after prettier formats JS/TS files on save.
    -- EslintFixAll is a command provided by the eslint LSP server.
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.mjs", "*.cjs" },
      callback = function()
        local clients = vim.lsp.get_clients({ bufnr = 0, name = "eslint" })
        if #clients > 0 then
          vim.cmd("EslintFixAll")
        end
      end,
    })
  end,
}
