return {
	"nvim-neorg/neorg",
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	dependencies = {
		"nvim-neorg/tree-sitter-norg",
		"nvim-neorg/tree-sitter-norg-meta",
	},
	opts = {
		load = {
			["core.defaults"] = {},
			["core.integrations.treesitter"] = {},
			["core.highlights"] = {},
			["core.queries.native"] = {},
			["core.concealer"] = {},
			["core.dirman"] = {
				config = {
					index = "index.norg",
					workspaces = {
						notes = "~/notes",
						nvim = vim.fn.stdpath("config"),
					},
				},
			},
			["core.ui"] = {},
			["core.clipboard"] = {},
			["core.keybinds"] = {},
			["core.export"] = {},
		},
	},
	config = function(_, opts)
		require("neorg").setup(opts)
	end,
}
