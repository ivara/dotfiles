local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local installed, lazy = pcall(require, "lazy")
if not installed then
  return
end

lazy.setup(
  -- importing directories
  {
    -- { import = "ivar.plugins" },
    --    { import = "ivar.plugins.lsp" },
  },
  -- end of importing dirs
  {
    checker = {
      enabled = true,
      notify = true,
    },
    change_detection = {
      notify = false,
    },
  }
)
