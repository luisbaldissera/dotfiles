require("config.makeprg").setup({
	providers = {
		{
			name = "latex",
			executable = "lualatex",
			files = { "main.tex" },
			-- Include -file-line-error so errors print cleanly as 'filename:line:error'
			makeprg = function(ctx)
				local safe_path = vim.fn.shellescape(ctx.matched_file)
				return "latexmk -lualatex -file-line-error -interaction=nonstopmode " .. safe_path
			end,
			-- Custom errorformat to capture LaTeX errors cleanly and ignore log garbage
			errorformat = "%f:%l: %m,%-G%.%#",
			watch = function(filepath, ctx)
				-- Auto-compile if any file changes inside your specific LaTeX project folder
				return filepath:sub(1, #ctx.root) == ctx.root
			end,
		},
		{
			name = "cargo",
			executable = "cargo",
			makeprg = "cargo build --message-format=short",
			files = { "Cargo.toml" },
			errorformat = "%f:%l:%c: %t%*[^:]: %m,%f:%l:%c: %m,%-G%.%#",
			watch = function(filepath, ctx)
				return filepath:match("Cargo%.toml$") or filepath:match("[/\\]src[/\\]")
			end,
		},
		{
			name = "maven",
			executable = "mvn",
			files = { "pom.xml" },
			makeprg = "mvn compile",
			-- Parses line and column out of standard Maven compiler plugin errors
			errorformat = "[ERROR] %f:[%l,%c] %m,[ERROR] %f:[%l,%v] %m,%-G%.%#",
			watch = function(filepath, ctx)
				-- Triggers only if pom.xml or anything inside the src/ directory is written
				return filepath:match("pom%.xml$") or filepath:match("[/\\]src[/\\]")
			end,
		},
		{
			name = "just",
			executable = "just",
			files = { "justfile" },
			case_insensitive = true,
			makeprg = "just",
			watch = function(filepath, ctx)
				return true -- Auto-run on any project file modification
			end,
		},
		{
			name = "cmake",
			executable = "cmake",
			files = { "CMakeLists.txt" },
			case_insensitive = false,
			makeprg = "cmake --build build",
			watch = function(filepath, ctx)
				return true
			end,
		},
		{
			name = "make",
			executable = "make",
			files = { "Makefile" },
			case_insensitive = true,
			makeprg = "make",
			watch = function(filepath, ctx)
				return true
			end,
		},
	},
})
