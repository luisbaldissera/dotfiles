local api = require("bundesbank.api")

local M = {}

--- Subtracts 'n' days from a given YYYY-MM-DD string
--- @param date_str string The date to be subtracted
--- @param days integer the number of days to subtract
--- @return string|osdate final_date representing date_str - days
local function subtract_days(date_str, days)
	local y, m, d = date_str:match("(%d+)-(%d+)-(%d+)")
	local time = os.time({ year = y, month = m, day = d })
	local new_time = time - (days * 24 * 60 * 60)
	return os.date("%Y-%m-%d", new_time)
end

--- Gets the exchange rate, falling back to the previous available day if necessary
---@param currency string 3-char string e.g. "EUR", "BRL", "USD", ...
---@param target_date string "YYYY-MM-DD"
---@return number|nil rate, string|nil actual_date_used
function M.get_rate(currency, target_date)
	-- Search up to 5 days backward to account for long holiday weekends (e.g., Easter)
	local start_date = subtract_days(target_date, 5)

	local res = api.fetch_data(currency, start_date, target_date)
	if not res or not res.data or not res.data.dataSets or #res.data.dataSets == 0 then
		return nil, nil
	end

	-- SDMX-JSON structures observations in a deeply nested dictionary:
	-- dataSets[1].series["0:0:0:0:0:0"].observations["{index}"]
	local series = res.data.dataSets[1].series
	local observations = series[vim.tbl_keys(series)[1]].observations

	-- Find the highest index (which corresponds to the latest date in our range)
	local latest_index = -1
	--- @type number
	local latest_rate = nil

	for idx_str, obs_data in pairs(observations) do
		--- @type integer
		local idx = assert(tonumber(idx_str))
		if idx > latest_index and obs_data[1] ~= vim.NIL then
			latest_index = idx
			latest_rate = assert(tonumber(obs_data[1]))
		end
	end

	-- Extract the actual date from the time periods array in the structure metadata
	local time_periods = res.data.structure.dimensions.observation[1].values
	local actual_date = time_periods[latest_index + 1].id

	return latest_rate, actual_date
end

return M
