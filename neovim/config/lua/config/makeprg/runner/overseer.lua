local M = {}

-- Asynchronous Background Build Execution Engine via Overseer
function M.run_background_build(cmd, efm, task_name)
	local overseer = require("overseer")
	-- Clean up older active task with the same name to prevent execution overlap
	local existing_tasks = overseer.list_tasks({ name = task_name, status = "RUNNING" })
	for _, t in ipairs(existing_tasks) do
		t:dispose(true) -- Force kill the old background run
	end

	local task = overseer.new_task({
		name = task_name,
		cmd = cmd,
		components = {
			{ "default" },
			{
				"on_output_quickfix",
				errorformat = efm,
				open_on_exit = "failure", -- Automatically opens quickfix window ONLY if compilation fails
				open_height = 8,
			},
		},
	})
	task:start()
end

return M
