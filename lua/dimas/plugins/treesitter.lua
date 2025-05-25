-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
treesitter.setup({
	-- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"bash",
		"c",
		"dockerfile",
		"gitignore",
		"go",
		"graphql",
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
	},
	-- enable rainbow
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
	-- auto install above language parsers
	auto_install = true,
})
