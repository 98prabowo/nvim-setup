return {
	"nvim-lualine/lualine.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	lazy = false,
	config = function()
		local lualine = require("lualine")
		local gruvbox = require("lualine.themes.gruvbox")

		local gruvbox_color = {
			red = "#FB4934",
			green = "#B8BB26",
			yellow = "#FABD2F",
			blue = "#83A598",
			purple = "#D3869B",
			aqua = "#8EC07C",
			orange = "#FE8019",
			gray = "#928374",
		}

		gruvbox.normal.a.bg = gruvbox_color.green

		lualine.setup({
			options = {
				theme = gruvbox,
				icon_enabled = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = {
					"encoding",
					{
						"fileformat",
						symbols = { unix = "" },
					},
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
