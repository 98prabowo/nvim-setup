local crates_setup, crates = pcall(require, "crates")
if not crates_setup then
	vim.notify("Crates not installed", vim.log.levels.ERROR)
	return
end

crates.setup()
