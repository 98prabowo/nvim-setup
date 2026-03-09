return {
	"Saecki/crates.nvim",
	tag = "stable",
	event = { "BufRead Cargo.toml" },
	config = function()
		local crates = require("crates")
		crates.setup({
			popup = {
				autofocus = true,
				border = "rounded",
			},
		})

		vim.keymap.set("n", "<leader>ct", crates.toggle, { desc = "Toggle crate info" })
		vim.keymap.set("n", "<leader>cr", crates.reload, { desc = "Reload crate info" })
		vim.keymap.set("n", "<leader>cu", crates.upgrade_crate, { desc = "Upgrade crate" })
		vim.keymap.set("n", "<leader>cU", crates.upgrade_all_crates, { desc = "Upgrade all crates" })
		vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { desc = "Show versions" })
		vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { desc = "Show features" })
		vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, { desc = "Show dependencies popup" })
	end,
}
