local mason_util = require("util.mason")

mason_util.ensure_installed("rust-analyzer")

return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { ".git", "Cargo.toml", "main.rs" },
}
