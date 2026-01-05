-- Neovim 0.11.5 Configuration

--------------------------------------------------------------------------------
-- Leader keys (must be set before lazy.nvim)
--------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--------------------------------------------------------------------------------
-- General Options
--------------------------------------------------------------------------------
-- Persistence
vim.opt.undofile = true
vim.opt.swapfile = false -- Disable swap files (undofile handles crash recovery)

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Display
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes:2"
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.scrolloff = 5
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99 -- Start with all folds open
vim.opt.foldenable = true -- Enable folding

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Command line
vim.opt.history = 200
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.cmdheight = 0
--------------------------------------------------------------------------------
-- Neovim 0.12 Specific Options
--------------------------------------------------------------------------------
-- Popup menu border
-- vim.o.pumborder = true

-- Auto-completion (triggers on CursorHoldI, respects updatetime)
-- vim.o.autocomplete = 'menu'

-- Completion options
vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy" }

--------------------------------------------------------------------------------
-- Diagnostics Configuration
--------------------------------------------------------------------------------
-- Diagnostic icons
local diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = "\u{f057} ",
  [vim.diagnostic.severity.WARN] = "\u{f071} ",
  [vim.diagnostic.severity.HINT] = "\u{f0eb} ",
  [vim.diagnostic.severity.INFO] = "\u{f05a} ",
}

-- Diagnostics state (for toggling)
local diag_state = {
  virtual_text = true,
  signs = true,
  underline = true,
  severity = nil, -- nil = all severities, or { min = vim.diagnostic.severity.X }
}

-- Apply diagnostics config based on current state
local function apply_diagnostics_config()
  vim.diagnostic.config({
    virtual_text = diag_state.virtual_text,
    signs = diag_state.signs and { text = diagnostic_icons } or false,
    underline = diag_state.underline,
    update_in_insert = false,
    severity_sort = true,
    severity = diag_state.severity,
    float = {
      border = "rounded",
      source = true,
      severity = diag_state.severity,
    },
  })
end

-- Toggle functions
local function toggle_virtual_text()
  diag_state.virtual_text = not diag_state.virtual_text
  apply_diagnostics_config()
  vim.notify("Diagnostics virtual text: " .. (diag_state.virtual_text and "ON" or "OFF"))
end

local function toggle_signs()
  diag_state.signs = not diag_state.signs
  apply_diagnostics_config()
  vim.notify("Diagnostics signs: " .. (diag_state.signs and "ON" or "OFF"))
end

local function toggle_underline()
  diag_state.underline = not diag_state.underline
  apply_diagnostics_config()
  vim.notify("Diagnostics underline: " .. (diag_state.underline and "ON" or "OFF"))
end

local function toggle_diagnostics()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
    vim.notify("Diagnostics: OFF")
  else
    vim.diagnostic.enable(true)
    vim.notify("Diagnostics: ON")
  end
end

-- Cycle through severity filters: All -> Errors -> Warnings -> Hints/Info -> All
local severity_levels = {
  { name = "All", filter = nil },
  { name = "Errors only", filter = { min = vim.diagnostic.severity.ERROR } },
  { name = "Warnings+", filter = { min = vim.diagnostic.severity.WARN } },
  { name = "Hints+", filter = { min = vim.diagnostic.severity.HINT } },
}
local current_severity_idx = 1

local function cycle_severity()
  current_severity_idx = current_severity_idx % #severity_levels + 1
  local level = severity_levels[current_severity_idx]
  diag_state.severity = level.filter
  apply_diagnostics_config()
  vim.notify("Diagnostics filter: " .. level.name)
end

local function set_severity(min_severity)
  if min_severity == nil then
    diag_state.severity = nil
    current_severity_idx = 1
    vim.notify("Diagnostics filter: All")
  else
    diag_state.severity = { min = min_severity }
    -- Update index to match
    for i, level in ipairs(severity_levels) do
      if level.filter and level.filter.min == min_severity then
        current_severity_idx = i
        vim.notify("Diagnostics filter: " .. level.name)
        break
      end
    end
  end
  apply_diagnostics_config()
end

-- Initial config
apply_diagnostics_config()

-- Export toggle functions for keymaps
_G.DiagnosticsToggle = {
  virtual_text = toggle_virtual_text,
  signs = toggle_signs,
  underline = toggle_underline,
  all = toggle_diagnostics,
  cycle_severity = cycle_severity,
  set_severity = set_severity,
  errors_only = function()
    set_severity(vim.diagnostic.severity.ERROR)
  end,
  warnings_plus = function()
    set_severity(vim.diagnostic.severity.WARN)
  end,
  hints_plus = function()
    set_severity(vim.diagnostic.severity.HINT)
  end,
  show_all = function()
    set_severity(nil)
  end,
}

--------------------------------------------------------------------------------
-- LSP Configuration (Native Neovim 0.11+)
--------------------------------------------------------------------------------
-- Enable LSP servers (configs are in lsp/ directory)
vim.lsp.enable({
  "lua_ls",
  "gopls",
  "rust_analyzer",
  "ts_ls",
  "bicep",
  "pyright",
  "yamlls",
  "jsonls",
})

-- LspAttach autocmd for keymaps and features
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

    -- Helper for buffer-local keymaps
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- LSP keymaps
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "grr", vim.lsp.buf.references, "References")
    map("n", "gri", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "grt", vim.lsp.buf.type_definition, "Type definition")
    map("n", "gra", vim.lsp.buf.code_action, "Code action")
    map("n", "grn", vim.lsp.buf.rename, "Rename")
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("i", "<C-s>", vim.lsp.buf.signature_help, "Signature help")

    -- Additional keymaps
    map("n", "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format")
    map("n", "<leader>cl", "<cmd>Lsp<cr>", "LSP info")

    -- Diagnostics (<leader>d)
    map("n", "<leader>xd", vim.diagnostic.open_float, "Line diagnostics")
    -- map("n", "<leader>dq", vim.diagnostic.setqflist, "Quickfix list")
    -- map("n", "<leader>dl", vim.diagnostic.setloclist, "Location list")

    -- Enable inlay hints if supported
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
})

--------------------------------------------------------------------------------
-- General Keymaps
--------------------------------------------------------------------------------
-- Escape insert mode
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

-- UI toggles (<leader>u)
vim.keymap.set("n", "<leader>uh", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
  vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
end, { desc = "Toggle inlay hints" })

vim.keymap.set("n", "<leader>ul", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle invisible chars" })

-- Diagnostics toggles (<leader>ud)
vim.keymap.set("n", "<leader>udd", DiagnosticsToggle.all, { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>udv", DiagnosticsToggle.virtual_text, { desc = "Toggle virtual text" })
vim.keymap.set("n", "<leader>uds", DiagnosticsToggle.signs, { desc = "Toggle signs" })
vim.keymap.set("n", "<leader>udu", DiagnosticsToggle.underline, { desc = "Toggle underline" })
vim.keymap.set("n", "<leader>udc", DiagnosticsToggle.cycle_severity, { desc = "Cycle severity filter" })
vim.keymap.set("n", "<leader>ude", DiagnosticsToggle.errors_only, { desc = "Errors only" })
vim.keymap.set("n", "<leader>udw", DiagnosticsToggle.warnings_plus, { desc = "Warnings and above" })
vim.keymap.set("n", "<leader>udh", DiagnosticsToggle.hints_plus, { desc = "Hints and above" })
vim.keymap.set("n", "<leader>uda", DiagnosticsToggle.show_all, { desc = "Show all severities" })

-- Better window navigation (if not using vim-tmux-navigator)
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Better indenting (stay in visual mode)
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Quickfix navigation
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open quickfix" })
vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open location list" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix" })

-- Buffer management
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- LSP info command (for native LSP without nvim-lspconfig)
vim.api.nvim_create_user_command("Lsp", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print("No LSP clients attached")
  else
    for _, client in ipairs(clients) do
      print(string.format("%s (id: %d)", client.name, client.id))
    end
  end
end, { desc = "Show attached LSP clients" })

--------------------------------------------------------------------------------
-- Autocommands
--------------------------------------------------------------------------------
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("resize-splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last-location", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Enable treesitter highlighting (Neovim 0.11+ native API)
-- STABILITY: Wrapped in pcall to prevent crashes from bad parsers/queries
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.bo[bufnr].filetype

    -- Skip special buffers
    if vim.bo[bufnr].buftype ~= "" then
      return
    end

    -- Skip large files
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok and stats and stats.size > max_filesize then
      return
    end

    -- Get the treesitter language for this filetype
    local lang = vim.treesitter.language.get_lang(ft) or ft

    -- STABILITY: Check if parser exists before trying to start
    local parser_ok = pcall(vim.treesitter.language.inspect, lang)
    if not parser_ok then
      return -- No parser available, skip silently
    end

    -- STABILITY: Check if highlight query is valid before starting
    local query_ok = pcall(vim.treesitter.query.get, lang, "highlights")
    if not query_ok then
      return -- Query has errors, skip silently
    end

    -- Start treesitter highlighting
    pcall(vim.treesitter.start, bufnr, lang)
  end,
})

--------------------------------------------------------------------------------
-- Load Lazy Plugin Manager
--------------------------------------------------------------------------------
require("config.lazy")

--------------------------------------------------------------------------------
-- Startup Health Check (shows warnings if plugins failed to load)
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("startup-health", { clear = true }),
  callback = function()
    vim.defer_fn(function()
      local lazy = require("lazy")
      local failed = {}
      for _, plugin in ipairs(lazy.plugins()) do
        if plugin._.loaded and plugin._.loaded.error then
          table.insert(failed, plugin.name)
        end
      end
      if #failed > 0 then
        vim.notify(
          "Failed to load plugins: " .. table.concat(failed, ", ") .. "\nRun :Lazy to see details.",
          vim.log.levels.ERROR
        )
      end
    end, 100)
  end,
})
