return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		local mason_nvim_dap = require("mason-nvim-dap")

		mason.setup({
			ui = { border = "rounded" },
		})

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

		mason_tool_installer.setup({
			-- list of formatters & linters for mason to install
			ensure_installed = {
				-- JavaScript / TypeScript
				"prettier", -- ts/js formatter

				-- Lua
				"stylua", -- lua formatter

				-- Python
				"black",
				"isort",

				-- Golang
				"goimports", -- golang auto imports
				"goimports-reviser", -- golang ordering imports
				"golangci-lint", -- golang diagnostic
				"impl", -- golang action

				-- C, C++, C#, Java, Cuda
				"clang-format", -- c, c++, c#, java, cuda formatter

				-- Java
				"google-java-format", -- java formatter with google style

				-- SQL
				"sqlfluff", -- sql linter/formatter

				-- Swift
				"swiftformat", -- swift formatter
				"swiftlint", -- swift linter

				-- Shell
				"shfmt", -- shell formatter

				-- YAML
				"yamllint", -- yaml linter
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
