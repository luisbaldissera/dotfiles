local M = {}

--- Internal helper function to split string in many different casings into
--- list of tokens.
---
--- For example:
--- - 'PascalCase' -> { 'pascal', 'case' }
--- - 'camelCase' -> { 'camel', 'case' }
--- - 'snake_case' -> { 'snake', 'case' }
---
--- @param str string the string to split into tokens
--- @return string[] list of tokens in lowercase
local function tokenize(str)
	-- Insert a space between a lowercase letter and an uppercase letter (for camel/Pascal)
	local spaced = str:gsub("(%l)(%u)", "%1 %2")
	-- Replace underscores and dashes with spaces
	spaced = spaced:gsub("[_%-]", " ")

	local words = {}
	-- Extract all alphanumeric words and convert them to lowercase
	for word in spaced:gmatch("%w+") do
		table.insert(words, word:lower())
	end

	return words
end

--- Converts string into 'PascalCase'
---
--- @param str string to convert
--- @return string str in pascal case
function M.pascal_case(str)
	local words = tokenize(str)
	local result = ""
	for _, word in ipairs(words) do
		-- Capitalize the first letter and append the rest of the word
		result = result .. word:sub(1, 1):upper() .. word:sub(2)
	end
	return result
end

--- Converts string into 'snake_case'
---
--- @param str string to convert
--- @return string str in snake case
function M.snake_case(str)
	return table.concat(tokenize(str), "_")
end

--- Converts string into 'camelCase'
---
--- @param str string to convert
--- @return string str in camel case
function M.camel_case(str)
	local words = tokenize(str)
	if #words == 0 then
		return ""
	end

	-- The first word stays strictly lowercase
	local result = words[1]

	-- Subsequent words get capitalized
	for i = 2, #words do
		result = result .. words[i]:sub(1, 1):upper() .. words[i]:sub(2)
	end
	return result
end

--- Converts string into 'CONSTANT_CASE'
---
--- @param str string to convert
--- @return string str in constant case
function M.constant_case(str)
	-- Join with underscores and make the entire result uppercase
	return table.concat(tokenize(str), "_"):upper()
end

--- Converts string into 'flatcase'.
---
--- Note that flatcase loses the different words if further casing is done.
---
--- @param str string to convert
--- @return string str in flat case
function M.flat_case(str)
	-- Join words with no delimiter at all
	return table.concat(tokenize(str), "")
end

--- Converts string into 'kebab-case'
---
--- @param str string to convert
--- @return string str in kebab case
function M.kebab_case(str)
	return table.concat(tokenize(str), "-")
end

return M
