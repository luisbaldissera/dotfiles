return {
	"gbprod/substitute.nvim",
	opts = {},
	keys = {
		{
			"s",
			function()
				require("substitute").operator()
			end,
			desc = "Substitute",
			mode = { "n" },
		},
		{
			"ss",
			function()
				require("substitute").line()
			end,
			desc = "Substitute line",
			mode = { "n" },
		},
		{
			"s",
			function()
				require("substitute").visual()
			end,
			desc = "Substitute",
			mode = { "x" },
		},
	},
}
