return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	event = "LspAttach",
	config = function()
		local saga = require("lspsaga")

		saga.setup({
			-- keybinds for navigation in lspsaga window
			scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
			-- use enter to open file with definition preview
			definition = {
				edit = "<CR>",
			},
			ui = {
				colors = {
					normal_bg = "#1D2021",
				},
			},
		})

		local groups = {
			LspSagaDefPreview = { bg = "#1D2021" },
			LspSagaFloatWin = { bg = "#1D2021" },
			NormalFloat = { bg = "#1D2021" },
		}

		for group, opts in pairs(groups) do
			vim.api.nvim_set_hl(0, group, opts)
		end
	end,
}
