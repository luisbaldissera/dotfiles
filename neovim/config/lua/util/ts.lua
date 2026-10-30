local M = {}

local state = {
	hl = {
		cache = {
			-- [filetype] = 'function'
		},
	},
}

function M.highlighter(filetype)
	filetype = filetype or vim.bo.filetype
	if state.hl.cache[filetype] then
		return state.hl.cache[filetype]
	end
	local ft_highlighter = function(text)
		-- TODO: Implement the highlighter
		return {} -- { [1] number, [2] number, [3] string }[]
	end
	state.hl.cache[filetype] = ft_highlighter
	return ft_highlighter
end
return M
