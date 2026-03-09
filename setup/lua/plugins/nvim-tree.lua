return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	config = function()
		local nvimtree = require("nvim-tree")

		-- change color for arrows in tree to light blue
		vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#BB3629" })

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

		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Open file explorer" })
	end,
}
