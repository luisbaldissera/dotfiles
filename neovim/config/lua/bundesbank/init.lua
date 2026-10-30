local rates = require("bundesbank.rates")

local M = {}

-- Store configuration (good practice for future expansion, e.g., caching)
M.config = {}

--- Initialize the plugin with optional config
---@param opts table|nil
function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

--- Fetches the exchange rate, falling back to the previous available day
---@param currency string e.g., "USD"
---@param date string|nil "YYYY-MM-DD" (Defaults to today if omitted)
---@return number|nil rate, string|nil actual_date_used
function M.get_rate(currency, date)
	if not date then
		date = os.date("%Y-%m-%d")
	end

	return rates.get_rate(currency, date)
end

--- Converts a foreign currency value to Euros based on the rate for a given date
---@param currency string e.g., "USD"
---@param value number The amount in the foreign currency
---@param date string|nil "YYYY-MM-DD" (Defaults to today if omitted)
---@return number|nil eur_value, number|nil rate, string|nil actual_date
function M.convert_to_eur(currency, value, date)
	local rate, actual_date = M.get_rate(currency, date)

	if not rate then
		vim.notify(
			string.format("Bundesbank API: Could not find rate for %s on %s", currency, date),
			vim.log.levels.WARN
		)
		return nil, nil, nil
	end

	-- The Bundesbank (via ECB) quotes reference rates as: 1 EUR = X Foreign Currency.
	-- To convert a foreign value to EUR, you divide the value by the exchange rate.
	local eur_value = value / rate

	return eur_value, rate, actual_date
end

return M
