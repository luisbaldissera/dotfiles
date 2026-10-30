return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		styles = {
			notification_history = {
				border = {
					bottom = true,
				},
				wo = {
					winblend = 0,
					wrap = true,
				},
			},
			notification = {
				border = false,
				wo = {
					winblend = 0,
					wrap = true,
				},
			},
		},
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		-- I prefer using oil.nvim
		explorer = { enabled = false },
		indent = {
			enabled = true,
			only_scope = true, -- only show indent guides of the scope
			only_current = true, -- only show indent guides in the current window
			animate = { enabled = false },
		},
		input = { enabled = true, prompt_pos = "left" },
		picker = { enabled = true, layout = { preset = "ivy" }, ui_select = true },
		notifier = {
			enabled = true,
			timeout = 3000, -- How long notifications stay on screen (ms)
			style = "minimal", -- Options: "compact", "minimal", or "fancy"
			width = {
				min = 0.99,
				max = 0.99,
			},
			top_down = false, -- true: Top-down (Top of screen) | false: Bottom-up
			margin = { top = 0, right = 0, bottom = 0 }, -- Margins around notifications
			padding = false,
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find files",
			mode = { "n" },
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find buffers",
			mode = { "n" },
		},
		{
			"<leader>gco",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git checkout",
			mode = { "n" },
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git log",
			mode = { "n" },
		},
	},
}
