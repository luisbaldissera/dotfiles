local function start_jdtls(root_dir, jar_bundles)
	local jdtls = require("jdtls")
	print(vim.inspect(jar_bundles))
	local extendedClientCapabilities = jdtls.extendedClientCapabilities
	extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
	jdtls.start_or_attach({
		cmd = { "jdtls" }, -- from Mason
		root_dir = root_dir,
		settings = {
			java = {
				inlayHints = {
					parameterNames = {
						enabled = "all",
					},
				},
				referencesCodeLens = { enabled = true },
				implementationsCodeLens = { enabled = true },
			},
		},
		init_options = {
			bundles = jar_bundles,
			extendedClientCapabilities = extendedClientCapabilities,
		},
		on_attach = function(_, bufnr) -- accepts client, bufnr
			jdtls.setup_dap({ hotcodereplace = "auto" })
			-- Keymaps to trigger java-tests
			vim.keymap.set("n", "<leader>tc", function()
				jdtls.test_class()
			end, { buffer = bufnr, desc = "Run Test Class" })
			vim.keymap.set("n", "<leader>tm", function()
				jdtls.test_nearest_method()
			end, { buffer = bufnr, desc = "Run Nearest Test Method" })
		end,
	})
end

return {
	"mfussenegger/nvim-jdtls",
	dependencies = { "mfussenegger/nvim-dap" },
	ft = { "java", "xml", "yaml", "properties", "gradle" },
	config = function()
		local mason_util = require("util.mason")
		local fs_util = require("util.fs")
		mason_util.ensure_installed(
			"jdtls",
			"java-debug-adapter",
			"java-test",
			"vscode-java-decompiler",
			"vscode-spring-boot-tools"
		)
		local bundle_pattern = "extension/server/*.jar"
		local jar_bundles = vim.fn.flatten({
			mason_util.find_files("java-debug-adapter", bundle_pattern),
			mason_util.find_files("vscode-java-decompiler", bundle_pattern),
			mason_util.find_files("java-test", bundle_pattern),
		})
		local root_dir = fs_util.find_latest_root({ "pom.xml", "build.gradle" })

		if root_dir then
			local augroup = vim.api.nvim_create_augroup("JdtlsConfigGroup", { clear = true })
			-- JDTLS LSP
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "java" },
				group = augroup,
				callback = function()
					start_jdtls(root_dir, jar_bundles)
				end,
			})
		end
	end,
}
