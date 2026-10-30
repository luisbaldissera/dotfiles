local mason_util = require("util.mason")

mason_util.ensure_installed("lua-language-server")

return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		{ ".lua.json", "lua.jsonc" },
		".git",
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			codeLens = { enable = false },
			hint = {
				enable = true,
				arrayIndex = "Auto",
				paramName = "Literal",
				paramType = true,
				semicolon = "SameLine",
				setType = true,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enabled = false,
			},
		},
	},
}
