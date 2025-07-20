local leetcode_status, leetcode = pcall(require, "leetcode")
if not leetcode_status then
	vim.notify("Leetcode not installed", vim.log.levels.ERROR)
	return
end

leetcode.setup({
	lang = "rust",
})
