local mason_util = require("util.mason")
local fs_util = require("util.fs")

mason_util.ensure_installed("copilot-language-server")

return {
	cmd = { "copilot-language-server", "--stdio" },
	filetypes = { "lua", "java" },
	root_dir = function(_, on_dir)
		-- Only start the server on git repositories
		local root = assert(fs_util.find_latest_root(".git"))
		on_dir(root)
	end,
	settings = {
		copilot = {
			advanced = {
				inlineSuggestCount = 3,
			},
		},
	},
}
