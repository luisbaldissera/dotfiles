-- map leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- options
local augroup = vim.api.nvim_create_augroup("OptionsGroup", { clear = true })
vim.o.autoindent = true
vim.o.background = "dark"
vim.o.backup = false
vim.o.compatible = false
vim.o.cursorline = true
vim.o.encoding = "utf-8"
vim.o.fillchars = "fold: "
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.laststatus = 3
vim.o.magic = true
vim.o.number = true
vim.o.path = ".,./**,/usr/include,,"
vim.o.relativenumber = true
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "markdown", "query" },
	group = augroup,
	callback = function()
		vim.o.relativenumber = false
		vim.o.number = false
	end,
})
vim.o.sessionoptions = "curdir,folds,help,tabpages,winsize,terminal,options"
vim.o.shiftwidth = 2
vim.o.shortmess = "filmrnxtToOF"
vim.o.showtabline = 2
vim.o.sidescroll = 5
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spelllang = "en_us"
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.termguicolors = false
vim.o.updatetime = 300
vim.o.writebackup = false

require("config.lazy")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help" },
	group = augroup,
	callback = function(args)
		local bufnr = args.buf
		vim.keymap.set("n", "q", function()
			vim.api.nvim_win_close(0, false)
		end, { silent = true, buffer = bufnr, desc = "Close help" })
	end,
})
-- tabs
vim.keymap.set("n", "<leader>tn", "<CMD>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", "<CMD>tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>th", "<CMD>-tabmove<CR>", { desc = "Move tab left" })
vim.keymap.set("n", "<leader>tl", "<CMD>+tabmove<CR>", { desc = "Move tab right" })

-- buffers
vim.keymap.set("n", "]b", "<CMD>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<CMD>bprevious<CR>", { desc = "Previous buffer" })

vim.cmd.colorscheme("gruvbox")
-- vim: fdm=marker
