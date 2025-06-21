local crates_setup, crates = pcall(require, "crates")
if not crates_setup then
	vim.notify("Crates not installed", vim.log.levels.ERROR)
	return
end

crates.setup()

vim.keymap.set("n", "<leader>ct", function()
	crates.toggle()
end, { desc = "Toggle crate info" })
vim.keymap.set("n", "<leader>cu", function()
	crates.upgrade_crate()
end, { desc = "Upgrade crate" })
vim.keymap.set("n", "<leader>cU", function()
	crates.upgrade_all_crates()
end, { desc = "Upgrade all crates" })
vim.keymap.set("n", "<leader>cv", function()
	crates.show_versions_popup()
end, { desc = "Show versions" })
vim.keymap.set("n", "<leader>cf", function()
	crates.show_features_popup()
end, { desc = "Show features" })
