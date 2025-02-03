return {
  "williamboman/mason-lspconfig.nvim",
  opts = function()
    local lspconfig = require("lspconfig")
    -- Bicep
    lspconfig.bicep.setup({
      capabilities = capabilities,
      cmd = { vim.fn.stdpath("data") .. "/mason/bin/bicep-lsp", "server" },
    })
    vim.cmd([[ autocmd BufNewFile,BufRead *.bicep set filetype=bicep ]])
  end,
}
