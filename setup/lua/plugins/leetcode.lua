return {
	"kawre/leetcode.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		local leetcode = require("leetcode")

		leetcode.setup({
			lang = "rust",
		})
	end,
}
