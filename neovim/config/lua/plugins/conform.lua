return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			java = {
				"palantir-java-format",
			},
			lua = {
				"stylua",
			},
			markdown = {
				"mdformat",
				"markdown-toc",
				"cbfmt",
			},
			xml = {
				"xmlformatter",
			},
			yaml = {
				"yamlfmt",
			},
			html = {
				"htmlbeautifier",
			},
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
	},
	config = function(_, opts)
		-- Ensure dependent packages are installed using Mason before setting up conform.nvim
		local required_packages = {}
		local unique_packages = {}
		for _, formatters in pairs(opts.formatters_by_ft or {}) do
			for _, formatter in ipairs(formatters) do
				if not unique_packages[formatter] then
					unique_packages[formatter] = true
					table.insert(required_packages, formatter)
				end
			end
		end
		if #required_packages > 0 then
			require("util.mason").ensure_installed(unpack(required_packages))
		end
		-- Setup conform.nvim
		require("conform").setup(opts)
	end,
}
