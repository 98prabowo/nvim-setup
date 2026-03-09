return {
	"tpope/vim-fugitive",
	cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
	keys = {
		{ "<leader>gs", vim.cmd.Git, desc = "Open Git Status (Fugitive)" },
	},
}
