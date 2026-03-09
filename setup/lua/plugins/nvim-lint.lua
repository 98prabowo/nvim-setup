return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile", "BufWritePost" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			go = { "golangcilint" },
			swift = { "swiftlint" },
			sql = { "sqlfluff" },
			yaml = { "yamllint" },
		}

		local sqlfluff = lint.linters.sqlfluff
		sqlfluff.args = {
			"lint",
			"--format=json",
			"--dialect=postgres",
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
