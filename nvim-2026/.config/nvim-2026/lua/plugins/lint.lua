-- nvim-lint: async linting for golangci-lint (and extensible to other linters)
-- https://github.com/mfussenegger/nvim-lint
--
-- Design decisions:
-- - Triggers only on save and buffer open — never on every keystroke
-- - Passes --fast to golangci-lint to skip slow linters (keep feedback < 5s on most projects)
-- - golangci-lint reads your project's .golangci.yml if present; --fast is a safe default otherwise
-- - Runs asynchronously — never blocks editing
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost" },
  config = function()
    local lint = require("lint")

    -- Configure golangci-lint arguments
    -- --fast: skips linters that require full type-checking (much faster, still very useful)
    -- --out-format: json is required for nvim-lint to parse output
    lint.linters.golangcilint.args = {
      "run",
      "--fast",
      "--out-format",
      "json",
      "--show-stats=false",
      "--allow-parallel-runners",
    }

    -- Map filetypes to linters
    lint.linters_by_ft = {
      go = { "golangcilint" },
    }

    -- Trigger linting on save and when entering a buffer
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        -- try_lint is async and non-blocking
        lint.try_lint()
      end,
    })
  end,
}
