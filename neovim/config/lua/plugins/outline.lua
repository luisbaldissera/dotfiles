return {
	"hedyhli/outline.nvim",
	lazy = true,
	keys = {
		{
			"<leader>o",
			function()
				require("outline").toggle()
			end,
			desc = "Toggle outline",
			mode = { "n" },
		},
	},
	opts = {},
}
