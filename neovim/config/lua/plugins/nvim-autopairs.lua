local function setup_custom_rules(npairs, custom_rules)
	local Rule = require("nvim-autopairs.rule")
	local cond = require("nvim-autopairs.conds")

	for ft, rules_func in pairs(custom_rules) do
		npairs.add_rules(rules_func(Rule, cond, ft))
	end
end

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		enabled_check_bracket_line = true,
		check_ts = true,
		custom_rules = {
			-- TODO: check why this is not fully working in Lua
			lua = function(Rule, cond, ft)
				return {
					Rule("if%s+.*%s+$", "then\n\nend", ft)
						:use_regex(true)
						:set_end_pair_length(4)
						:with_pair(cond.before_regex("%s*if%s+.*"))
						:with_cr(cond.none()),

					Rule("elseif%s+.*%s+$", "then\n\nend", ft)
						:use_regex(true)
						:set_end_pair_length(4)
						:with_pair(cond.before_regex("%s*elseif%s+.*"))
						:with_cr(cond.none()),

					Rule("for%s+.*%s+$", "do\n\nend", ft)
						:use_regex(true)
						:set_end_pair_length(3)
						:with_pair(cond.before_regex("%s*for%s+.*"))
						:with_cr(cond.none()),

					Rule("while%s+.*%s+$", "do\n\nend", ft)
						:use_regex(true)
						:set_end_pair_length(3)
						:with_pair(cond.before_regex("%s*while%s+.*"))
						:with_cr(cond.none()),

					Rule("function%(.*%)%$", "\n\nend", ft)
						:use_regex(true)
						:set_end_pair_length(3)
						:with_pair(cond.before_regex("%s*function%(.*%)"))
						:with_cr(cond.none()),
				}
			end,
		},
	},
	config = function(_, opts)
		local npairs = require("nvim-autopairs")
		npairs.setup(opts)
		setup_custom_rules(npairs, opts.custom_rules)
	end,
}
