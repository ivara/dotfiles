-- Lua Language Server
-- https://luals.github.io/
-- Note: lazydev.nvim handles workspace library and vim globals automatically
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        -- library is managed by lazydev.nvim
      },
      diagnostics = {
        -- globals are managed by lazydev.nvim
      },
      hint = {
        enable = true,
        arrayIndex = "Disable",
        setType = true,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
