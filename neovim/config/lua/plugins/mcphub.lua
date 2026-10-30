return {
	"ravitemer/mcphub.nvim",
	opts = {
		on_ready = function(hub)
			if hub.refresh_native_servers then
				hub:refresh_native_servers()
			end
		end,
	},
}
