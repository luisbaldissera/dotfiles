return {
	{
		"ramilito/kubectl.nvim",
		-- use a release tag to download pre-built binaries
		version = "2.*",
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'make build',
		-- OR if you use nix, build from source with:
		-- build = 'nix run .#build-plugin',
		dependencies = "saghen/blink.download",
		cmd = "KubeCluster",
		opts = {},
		config = function(_, opts)
			local kubectl = require("kubectl")
			kubectl.setup(opts)
			vim.api.nvim_create_user_command("KubeCluster", kubectl.open, { desc = "Open kubernetes cluster" })
			local augroup = vim.api.nvim_create_augroup("kubectl.mappings", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = augroup,
				pattern = "k8s_*",
				callback = function(evt)
					local bufnr = evt.buf
					vim.keymap.set("n", "q", kubectl.close, { buffer = bufnr })
				end,
			})
		end,
	},
}
