-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.api.nvim_set_keymap

map("i", "jk", "<Esc>", { noremap = true, silent = false })

-- Move a line up and down in normal mode
-- map("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
-- map("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Move selected lines up and down in visual mode
-- map("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
-- map("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
--
-- map("v", "<M-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
-- map("v", "<M-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- map("n", "<M-a>", ":lua print('hello')", { noremap = true, silent = true })
