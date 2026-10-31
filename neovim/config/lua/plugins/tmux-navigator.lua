return {
	"christoomey/vim-tmux-navigator",
	init = function()
		vim.g.tmux_navigator_no_mappings = 1
	end,
	keys = {
		{ "<C-w>h", "<Cmd>TmuxNavigateLeft<CR>", desc = "Navigate left" },
		{ "<C-w>j", "<Cmd>TmuxNavigateDown<CR>", desc = "Navigate down" },
		{ "<C-w>k", "<Cmd>TmuxNavigateUp<CR>", desc = "Navigate up" },
		{ "<C-w>l", "<Cmd>TmuxNavigateRight<CR>", desc = "Navigate right" },
		{ "<C-w><Left>", "<Cmd>TmuxNavigateLeft<CR>", desc = "Navigate left" },
		{ "<C-w><Down>", "<Cmd>TmuxNavigateDown<CR>", desc = "Navigate down" },
		{ "<C-w><Up>", "<Cmd>TmuxNavigateUp<CR>", desc = "Navigate up" },
		{ "<C-w><Right>", "<Cmd>TmuxNavigateRight<CR>", desc = "Navigate right" },
	},
}
