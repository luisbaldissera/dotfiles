local M = {}

--- Find the latest root directory based on the provided root markers.
---
--- @param root_markers string[]|string A list of (or single) root marker filenames to look for.
--- @param start_path? string The starting path to search from. Defaults to the current working directory if not provided.
--- @return string|nil path to the latest root directory if found, otherwise nil.
function M.find_latest_root(root_markers, start_path)
	-- When single string is passsed to root markers, treat as singleton list
	if type(root_markers) == "string" then
		root_markers = { root_markers }
	end
	-- Defaults to current working directory if start_path is not provided.
	if start_path == nil or start_path == "" then
		start_path = vim.fn.getcwd()
	end
	local path = vim.fn.fnamemodify(start_path, ":p")
	while path ~= "/" do
		for _, marker in ipairs(root_markers) do
			if vim.fn.glob(path .. "/" .. marker) ~= "" then
				return path
			end
		end
		path = vim.fn.fnamemodify(path, ":h")
	end
	return nil
end

return M
