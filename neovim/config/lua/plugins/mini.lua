return {
	"echasnovski/mini.nvim",
	version = "*",
	opts = function()
		return {
			ai = {},
			align = {},
			icons = {},
			jump = {},
			move = {},
			trailspace = {},
			visits = {},
		}
	end,
	config = function(_, opts)
		for mini_module, module_opts in pairs(opts) do
			require("mini." .. mini_module).setup(module_opts)
		end
	end,
}
