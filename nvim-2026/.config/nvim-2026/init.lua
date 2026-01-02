-- Neovim 0.12 Configuration
-- Using native LSP (no nvim-lspconfig required)

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
vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.scrolloff = 5
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

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
vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
})

--------------------------------------------------------------------------------
-- Filetype Detection
--------------------------------------------------------------------------------
vim.filetype.add({
	extension = {
		bicep = "bicep",
	},
})

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
		map("n", "<leader>dd", vim.diagnostic.open_float, "Line diagnostics")
		map("n", "<leader>dq", vim.diagnostic.setqflist, "Quickfix list")
		map("n", "<leader>dl", vim.diagnostic.setloclist, "Location list")

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
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

vim.keymap.set("n", "<leader>ul", function()
	vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle invisible chars" })

-- Undotree (built-in in 0.12!)
vim.keymap.set("n", "<leader>uu", "<cmd>Undotree<cr>", { desc = "Undo tree" })

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
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
	callback = function()
		-- Skip large files
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(0))
		if ok and stats and stats.size > max_filesize then
			return
		end
		-- Start treesitter if parser is available
		if pcall(vim.treesitter.start) then
			-- Enable treesitter-based folds
			vim.wo[0][0].foldmethod = "expr"
			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[0][0].foldenable = false -- Don't fold by default
		end
	end,
})

--------------------------------------------------------------------------------
-- Load Lazy Plugin Manager
--------------------------------------------------------------------------------
require("config.lazy")
