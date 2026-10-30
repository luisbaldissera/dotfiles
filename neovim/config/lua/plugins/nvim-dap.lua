local function configure_osv_dap_client(osv)
	local dap = require("dap")
	--@type dap.Configuration
	dap.configurations.lua = {
		{
			type = "nlua",
			request = "attach",
			name = "Attach to running Neovim instance",
		},
	}
	dap.adapters.nlua = function(callback)
		callback({
			type = "server",
			host = osv.host,
			port = osv.port,
		})
	end
end

-- TODO: the autocompletion in the input with the LSP/DAP context is not yet working
local function dap_conditional_breakpoint_with_lsp()
	local ts_util = require("util.ts")
	local curbuf = vim.api.nvim_get_current_buf()
	local curft = vim.bo[curbuf].filetype
	local curpos = vim.api.nvim_win_get_cursor(0)

	vim.ui.input({
		prompt = "Breakpoint condition",
		highlight = ts_util.highlighter(curft),
		scope = "cursor",
	}, function(input)
		if input and input ~= "" then
			require("dap").set_breakpoint(input)
		end
	end)
end

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jbyuki/one-small-step-for-vimkind",
	},
	keys = {
		{
			"gdc",
			function()
				require("dap").continue()
			end,
			desc = "Dap continue",
		},
		{
			"gdn",
			function()
				require("dap").step_over()
			end,
			desc = "Step over",
		},
		{
			"gdi",
			function()
				require("dap").step_into()
			end,
			desc = "Step into",
		},
		{
			"gdo",
			function()
				require("dap").step_out()
			end,
			desc = "Step out",
		},
		{
			"gdb",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle breakpoint",
		},
		{
			"gdB",
			dap_conditional_breakpoint_with_lsp,
			desc = "Set conditional breakpoint",
		},
		{
			"gdL",
			function()
				vim.ui.input({ prompt = "Log point message: " }, function(input)
					if input then
						require("dap").set_breakpoint(nil, nil, input)
					end
				end)
			end,
			desc = "Set log point",
		},
	},
	lazy = true,
	opts = {
		osv = {
			host = "127.0.0.1",
			port = 8086,
		},
		signs = {
			breakpoint = "",
			breakpoint_condition = "",
			log_point = "",
			stopped = "",
			breakpoint_rejected = "",
		},
	},
	config = function(_, opts)
		opts = opts or {}
		-- Define DAP signs
		local signs = opts.signs or {}
		local string_util = require("util.str")
		for name, icon in pairs(signs) do
			local hl = "Dap" .. string_util.pascal_case(name)
			vim.fn.sign_define(hl, { text = icon, texthl = hl, linehl = "", numhl = "" })
		end

		local osv = opts.osv or {}
		-- DAP OSV registered when the CWD is the neovim config
		if vim.fn.getcwd() == vim.fn.stdpath("config") then
			configure_osv_dap_client(osv)
		end
		-- Create command to start vim with OSV server running
		vim.api.nvim_create_user_command("OsvServer", function()
			require("osv").launch({
				host = osv.host,
				port = osv.port,
			})
		end, { desc = "Launch OSV server" })
	end,
}
