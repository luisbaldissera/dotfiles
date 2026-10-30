local M = {}

--- @class MatchProviderContext
---   @field bufnr integer The buffer number
---   @field start_path string
---   @field matched_file string
---   @field root string

--- @class Provider
--- 	@field name string
--- 	@field executable? string
--- 	@field files? string|string[]
--- 	@field makeprg string|function
--- 	@field errorformat? string
--- 	@field watch? function
--- 	@field case_insensitive? boolean

--- Match context extractor logic
---
--- @param provider Provider
--- @param start_path string
--- @param bufnr integer
--- @return boolean, MatchProviderContext?
local function match_provider(provider, start_path, bufnr)
	if vim.fn.executable(provider.executable) ~= 1 then
		return false, nil
	end

	local context = { bufnr = bufnr, start_path = start_path }

	local files = provider.files
	if files then
		local targets = {}
		if type(files) == "string" then
			--- @type string[]
			files = { files }
		end
		for _, f in ipairs(files) do
			table.insert(targets, provider.case_insensitive and f:lower() or f)
		end

		local found = vim.fs.find(function(name, _)
			local match_name = provider.case_insensitive and name:lower() or name
			return vim.tbl_contains(targets, match_name)
		end, { path = start_path, limit = 1, upward = true })

		if #found > 0 then
			context.matched_file = found[1]
			context.root = vim.fs.dirname(found[1])
			return true, context
		end
	end

	return false, nil
end

--- Evaluates active buffer parameters
---
--- @param providers Provider[]
--- @param default_makeprg string
--- @return string?
local function update_makeprg(providers, default_makeprg)
	if vim.bo.buftype ~= "" then
		return
	end

	local bufnr = vim.api.nvim_get_current_buf()
	local buf_name = vim.api.nvim_buf_get_name(bufnr)
	local start_path = (buf_name ~= "") and vim.fs.dirname(buf_name) or vim.fn.getcwd()

	for _, provider in ipairs(providers) do
		local matched, context = match_provider(provider, start_path, bufnr)
		if matched then
			local prg = provider.makeprg
			if type(prg) == "function" then
				--- @type string
				prg = prg(context)
			end

			vim.bo[bufnr].makeprg = prg
			if provider.errorformat then
				vim.bo[bufnr].errorformat = provider.errorformat
			end
			return provider.name
		end
	end

	vim.bo[bufnr].makeprg = default_makeprg
	return "default"
end

--- @class Opts
--- 	@field default_makeprg string
--- 	@field runner "overseer"
--- 	@field providers Provider[]

--- @param opts Opts
function M.setup(opts)
	opts = opts or {}
	local default_opts = require("config.makeprg.default_opts")
	local new_opts = vim.tbl_deep_extend("keep", opts, default_opts)
	local providers = new_opts.providers
	local default_makeprg = new_opts.default_makeprg
	-- Wire up your Autocommands
	local group = vim.api.nvim_create_augroup("DynamicMakePrg", { clear = true })

	local runner = require("config.makeprg.runner." .. new_opts.runner)
	vim.api.nvim_create_autocmd({ "BufEnter", "FileType", "DirChanged" }, {
		group = group,
		callback = function()
			update_makeprg(providers, default_makeprg)
		end,
	})

	-- The Background Watcher trigger
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		callback = function(args)
			local filepath = vim.api.nvim_buf_get_name(args.buf)
			if filepath == "" then
				return
			end

			local start_path = vim.fs.dirname(filepath)

			for _, provider in ipairs(providers) do
				local matched, context = match_provider(provider, start_path, args.buf)
				if matched then
					if provider.watch and provider.watch(filepath, context) then
						local prg = provider.makeprg
						if type(prg) == "function" then
							prg = prg(context)
						end

						local efm = provider.errorformat or vim.o.errorformat
						local t_name = vim.fn.getcwd() .. ": " .. provider.name

						runner.run_background_build(prg, efm, t_name)
					end
					break
				end
			end
		end,
	})
end

return M
