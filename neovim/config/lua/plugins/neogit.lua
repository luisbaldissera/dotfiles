return {
	"NeogitOrg/neogit",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
	},
	opts = {
		integrations = {
			diffview = true,
		},
	},
	keys = {
		{
			"<leader>gg",
			function()
				require("neogit").open()
			end,
			desc = "Git status",
			mode = { "n" },
		},
	},
}
