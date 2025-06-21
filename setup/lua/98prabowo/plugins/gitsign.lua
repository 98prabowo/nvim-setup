local gitsigns_setup, gitsigns = pcall(require, "gitsigns")
if not gitsigns_setup then
	vim.notify("Gitsigns not installed", vim.log.levels.ERROR)
	return
end

gitsigns.setup()
