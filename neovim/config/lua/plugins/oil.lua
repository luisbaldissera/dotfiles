return {
	"stevearc/oil.nvim",
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
	keys = {
		{
			"-",
			function()
				require("oil").open()
			end,
			desc = "Files",
			mode = { "n" },
		},
	},
	opts = {
		delete_to_trash = false,
		lsp_file_methods = {
			autosave_changes = true,
		},
		-- keymaps = {
		-- 	["g?"] = { "actions.show_help", mode = "n" },
		-- 	["q"] = {
		-- 		"actions.close",
		-- 		desc = "Close",
		-- 	},
		-- 	["<C-y>"] = {
		-- 		"actions.copy_to_system_clipboard",
		-- 		desc = "Copy contents",
		-- 	},
		-- 	["gx"] = {
		-- 		"actions.open_external",
		-- 		desc = "Open with external program",
		-- 	},
		-- 	["-"] = {
		-- 		"actions.parent",
		-- 		desc = "Navigate to parent",
		-- 	},
		-- 	["<C-p>"] = {
		-- 		"actions.preview",
		-- 		opts = {
		-- 			horizontal = true,
		-- 			split = "botright",
		-- 		},
		-- 		desc = "Preview",
		-- 	},
		-- 	["<M-d>"] = {
		-- 		"actions.preview_scroll_down",
		-- 		desc = "Scroll preview down",
		-- 	},
		-- 	["<M-u>"] = {
		-- 		"actions.preview_scroll_up",
		-- 		desc = "Scroll preview up",
		-- 	},
		-- 	["<CR>"] = {
		-- 		"action.select",
		-- 		opts = {
		-- 			close = true,
		-- 		},
		-- 		desc = "Open",
		-- 	},
		-- 	["<C-v>"] = {
		-- 		"action.select",
		-- 		opts = {
		-- 			vertical = true,
		-- 		},
		-- 		desc = "Open vertical split",
		-- 	},
		-- 	["<C-s>"] = {
		-- 		"actions.select",
		-- 		opts = {
		-- 			horizontal = true,
		-- 		},
		-- 		desc = "Open horizontal split",
		-- 	},
		-- 	["<C-t>"] = {
		-- 		"actions.select",
		-- 		opts = {
		-- 			tab = true,
		-- 		},
		-- 		desc = "Open in new tab",
		-- 	},
		-- },
	},
}
