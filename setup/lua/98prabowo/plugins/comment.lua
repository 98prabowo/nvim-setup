local comment_setup, comment = pcall(require, "Comment")
if not comment_setup then
	vim.notify("Comment not installed", vim.log.levels.ERROR)
	return
end

comment.setup()
