local M = {}

local function on_lsp_attach(args)
	local bufnr = args.buf
	local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

	-- Helper function for same options with different descriptions in the mappings
	local function opt(desc)
		return {
			buffer = bufnr,
			silent = true,
			desc = desc,
		}
	end

	-- Folding provided by LSP
	if client:supports_method("textDocument/foldingRange") then
		local win = vim.api.nvim_get_current_win()
		vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		vim.wo[win][0].foldmethod = "expr"
		vim.wo[win][0].foldlevel = 999
	end

	vim.keymap.set("n", "grD", "<CMD>Trouble lsp_declarations<CR>", opt("Declaration"))
	vim.keymap.set("n", "grd", "<CMD>Trouble lsp_definitions<CR>", opt("Definition"))
	vim.keymap.set("n", "gri", "<CMD>Trouble lsp_implementations<CR>", opt("Implementation"))
	vim.keymap.set("n", "grr", "<CMD>Trouble lsp_references<CR>", opt("References"))
	vim.keymap.set("n", "grt", "<CMD>Trouble lsp_type_definitions<CR>", opt("Type definition"))
	vim.keymap.set("n", "grn", vim.lsp.buf.rename, opt("Rename"))
	vim.keymap.set("n", "gra", vim.lsp.buf.code_action, opt("Code action"))
	vim.keymap.set("n", "grx", vim.lsp.codelens.run, opt("Run code-lens"))
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opt("Hover"))
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opt("Signature"))
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, opt("Next diagnostic"))
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, opt("Previous diagnostic"))
	-- Set inlayhints if supported by the client
	if client ~= nil and client:supports_method("textDocument/inlayHint", bufnr) then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

function M.setup()
	vim.diagnostic.config({
		signs = false,
		virtual_lines = { current_line = true },
		virtual_text = { current_line = false },
	})
	local augroup = vim.api.nvim_create_augroup("lsp.config", { clear = true })
	vim.api.nvim_create_autocmd("LspAttach", {
		desc = "Global LSP keymaps and settings",
		group = augroup,
		callback = on_lsp_attach,
	})
	local lsp_configs = vim.lsp.get_configs()

	--- @type string[]
	local lsp_config_names = {}
	for _, lsp_config in ipairs(lsp_configs) do
		table.insert(lsp_config_names, lsp_config.name)
	end
	-- Enable all LSP configs
	if #lsp_config_names > 0 then
		vim.lsp.enable(lsp_config_names)
	end
	vim.lsp.codelens.enable(true)
end

return M
