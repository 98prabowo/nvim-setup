return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000, -- Make sure theme load before other plugin
	config = function()
		require("gruvbox").setup({
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard",
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		})

		-- Aktifkan temanya di sini
		vim.o.background = "dark"
		vim.opt.termguicolors = true
		vim.cmd("colorscheme gruvbox")
	end,
}
