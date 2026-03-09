local treesitter_status, treesitter = pcall(require, "nvim-treesitter")
if not treesitter_status then
	vim.notify("treesitter not installed", vim.log.levels.ERROR)
	return
end

treesitter.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

treesitter.install({
	"bash",
	"c",
	"css",
	"dockerfile",
	"gitignore",
	"go",
	"gomod",
	"gotmpl",
	"gowork",
	"graphql",
	"html",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"swift",
	"sql",
	"toml",
	"vim",
	"yaml",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"bash",
		"c",
		"css",
		"dockerfile",
		"go",
		"gomod",
		"gotmpl",
		"gowork",
		"graphql",
		"html",
		"json",
		"lua",
		"markdown",
		"python",
		"rust",
		"swift",
		"sql",
		"toml",
		"vim",
		"yaml",
	},
	callback = function()
		vim.treesitter.start()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "rust", "python", "javascript", "go" },
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
