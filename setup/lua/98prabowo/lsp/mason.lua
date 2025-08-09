local mason_status, mason = pcall(require, "mason")
if not mason_status then
	vim.notify("Mason not installed", vim.log.levels.ERROR)
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	vim.notify("Mason lsp config not installed", vim.log.levels.ERROR)
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	vim.notify("Mason null ls not installed", vim.log.levels.ERROR)
	return
end

local mason_nvim_dap_status, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not mason_nvim_dap_status then
	vim.notify("Mason dap not installed", vim.log.levels.ERROR)
	return
end

mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"arduino_language_server", -- Arduino
		"bashls", -- Bash/ZSH
		"clangd", -- C
		"gopls", -- Golang
		"graphql", -- GraphQL
		"jedi_language_server", -- Python
		"jsonls", -- JSON
		"lemminx", -- XML
		"lua_ls", -- Lua
		"rust_analyzer", -- Rust
		"sqlls", -- SQL
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

		-- Python
		"black", -- python formatter
		"isort", -- python sorter

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
	ensure_installed = {
		"codelldb",
	},
	-- auto-install configured debugger
	automatic_installation = true,
})
