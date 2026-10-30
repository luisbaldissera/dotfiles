local mason_util = require("util.mason")
local fs_util = require("util.fs")

mason_util.ensure_installed("lemminx")

return {
	cmd = { "lemminx" },
	filetypes = { "xml", "xsd", "xsl", "xslt" },
	root_dir = function(bufnr, on_dir)
		on_dir(fs_util.find_latest_root("pom.xml"))
	end,
	settings = {
		xml = {
			validation = {
				enabled = true,
				noGrammar = "warning",
			},
			maven = {
				enabled = true,
			},
		},
	},
}
