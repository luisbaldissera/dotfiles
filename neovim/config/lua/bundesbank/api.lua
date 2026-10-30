local curl = require("plenary.curl")

local M = {}

--- Fetch the exchange rate for a specific date range
---@param currency string e.g., "USD", "CHF"
---@param start_date string|osdate Format: "YYYY-MM-DD"
---@param end_date string|osdate Format: "YYYY-MM-DD"
---@return table|nil parsed_json
function M.fetch_data(currency, start_date, end_date)
	-- D = Daily, {currency} = Target, EUR = Base, BB.AC.000 = Bundesbank specific identifiers
	local flow_ref = "BBEX3"
	local key = string.format("D.%s.EUR.BB.AC.000", currency)
	local url = string.format("https://api.statistiken.bundesbank.de/rest/data/%s/%s", flow_ref, key)

	local response = curl.get(url, {
		query = {
			-- TODO: convert osdate to string
			startPeriod = start_date,
			endPeriod = end_date,
			detail = "dataonly",
		},
		headers = {
			-- Request SDMX-JSON format
			Accept = "application/vnd.sdmx.data+json;version=1.0.0",
		},
	})

	if response.status ~= 200 then
		return nil
	end

	return vim.fn.json_decode(response.body)
end

return M
