return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			go = { "goimports", "goimports-reviser", "gofmt" },
			rust = { "rustfmt", lsp_format = "fallback" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			java = { "google-java-format" },
			swift = { "swiftformat" },
			kotlin = { "ktlint" },
			sh = { "shfmt" },
		},
		formatters = {
			black = { prepend_args = { "--fast" } },
			isort = { prepend_args = { "--profile", "black" } },
			["clang-format"] = { prepend_args = { "--style=Google" } },
			shfmt = { prepend_args = { "-i", "2" } },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
