-- Treesitter: syntax highlighting and parsing
-- STABILITY NOTES:
-- - Parsers are compiled .so files that can become corrupted/incompatible
-- - Keep the parser list minimal to reduce surface area for issues
-- - If crashes occur, delete ~/.local/share/nvim-2026/lazy/nvim-treesitter/parser/
--   and restart nvim to reinstall fresh parsers
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "bash",
      "bicep",
      "c_sharp",
      "razor", -- razor pages
      "css",
      "scss",
      "csv",
      "dockerfile",
      "editorconfig",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "gosum",
      "javascript",
      "json",
      "lua",
      "luadoc",
      "make",
      "markdown_inline",
      "markdown",
      "passwd",
      -- "python",
      "rust",
      "sql",
      "svelte",
      "tmux",
      "toml",
      "tsx", -- TypeScript and TSX grammars
      "yaml",
      "zig",
      "zsh",
    })
  end,
}
