return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-null-ls.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_null_ls = require("mason-null-ls")
		local mason_nvim_dap = require("mason-nvim-dap")

		mason.setup()

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"bashls", -- Bash/ZSH
				"clangd", -- C
				"cssls", -- CSS
				"gopls", -- Golang
				"graphql", -- GraphQL
				"html", -- HTML
				"jsonls", -- JSON
				"lemminx", -- XML
				"ltex", -- Latex
				"lua_ls", -- Lua
				"pyright", -- Python
				"ruff", -- Python
				"rust_analyzer", -- Rust
				"solidity_ls_nomicfoundation", -- Solidity
				"sqlls", -- SQL
				"stylua", -- Lua
				"ts_ls", -- TS
				"yamlls", -- YAML
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
			automatic_enable = false,
		})

		mason_null_ls.setup({
			-- list of formatters & linters for mason to install
			ensure_installed = {
				-- JavaScript / TypeScript
				"prettier", -- ts/js formatter

				-- Lua
				"stylua", -- lua formatter

				-- Golang
				"gofmt", -- golang formatter
				"goimports", -- golang auto imports
				"goimports_reviser", -- golang ordering imports
				"golangci_lint", -- golang diagnostic
				"impl", -- golang action

				-- C, C++, C#, Java, Cuda
				"clang_format", -- c, c++, c#, java, cuda formatter

				-- Swift
				"swiftformat", -- swift formatter
				"swiftlint", -- swift linter

				-- Java
				"google_java_format", -- java formatter with google style

				-- Kotlin
				"ktlint", -- kotlin formatter and diagnostic

				-- SQL
				"sqlfluff", -- sql linter/formatter

				-- YAML
				"yamllint", -- yaml linter

				-- Shell
				"shfmt", -- shell formatter
			},
			-- auto-install configured formatters & linters (with null-ls)
			automatic_installation = true,
		})

		mason_nvim_dap.setup({
			-- list of debuggers for mason to install
			ensure_installed = { "codelldb" },
			-- auto-install configured debugger
			automatic_installation = true,
		})
	end,
}
