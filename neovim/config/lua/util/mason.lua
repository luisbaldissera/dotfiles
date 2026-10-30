local M = {}

--- Retrieve the installation path of a package from Mason.
---
--- @param pkg string the name of the package.
--- @return string|nil path installation path of the the package.
function M.install_path(pkg)
	local mason_registry = require("mason-registry")
	return mason_registry.get_package(pkg):get_install_path()
end

--- Find files for a package from Mason that matches a certain pattern. It uses |globpath()| internally.
---
--- @param pkg string name of the package.
--- @param pattern string pattern to find the files. It follows same pattern as |glob()|.
--- @return table files list of the found files.
function M.find_files(pkg, pattern)
	local base_path = assert(M.install_path(pkg))
	return vim.fn.globpath(base_path, pattern, true, true)
end

--- Ensure certain packages are installed in Mason.
---
--- @param ... string list of packages name
function M.ensure_installed(...)
	local mason_registry = require("mason-registry")

	local packages = { ... }
	local to_install = {}

	for _, package_name in ipairs(packages) do
		-- Using pcall ensures it won't crash if you accidentally pass a typo/invalid package name
		local ok, pkg = pcall(mason_registry.get_package, package_name)

		if ok then
			if not pkg:is_installed() then
				table.insert(to_install, package_name)
			end
		else
			vim.notify("Mason package not found in registry: " .. package_name, vim.log.levels.WARN)
		end
	end

	-- 3. Install the remaining ones if the list isn't empty
	if #to_install > 0 then
		vim.notify("Mason: Installing missing packages: " .. table.concat(to_install, ", "), vim.log.levels.INFO)
		vim.cmd.MasonInstall(unpack(to_install))
	end
end

return M
