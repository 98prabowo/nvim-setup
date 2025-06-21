local nvimtree_setup, nvimtree = pcall(require, "nvim-tree")
if not nvimtree_setup then
	vim.notify("nvim-tree not installed", vim.log.levels.ERROR)
	return
end

-- recommended settings from nvim-tree docs
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- change color for arrows in tree to light blue
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#BB3629 ]])

nvimtree.setup({
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "→",
					arrow_open = "↓",
				},
			},
		},
	},

	-- disable window_picker for
	-- explorer to work well with
	-- window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
})
