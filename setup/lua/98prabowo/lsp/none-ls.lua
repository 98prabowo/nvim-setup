-- import null-ls plugin safely
local setup, none_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local action = none_ls.builtins.code_actions -- to setup code actions
local formatting = none_ls.builtins.formatting -- to setup formatters
local diagnostics = none_ls.builtins.diagnostics -- to setup linters

none_ls.setup({
	-- setup formatters & linters
	sources = {
		-- JavaScript / TypeScript
		formatting.prettier,

		-- Lua
		formatting.stylua,

		-- Python
		formatting.black.with({
			extra_args = { "--fast" },
		}),
		formatting.isort.with({
			extra_args = { "--profile", "black" },
		}),

		-- Golang
		formatting.gofmt,
		formatting.goimports,
		formatting.goimports_reviser,
		diagnostics.golangci_lint,
		action.impl,

		-- C, C++, C#, CUDA
		formatting.clang_format.with({
			extra_args = { "--style=Google" },
		}),

		-- Swift
		formatting.swiftformat,
		diagnostics.swiftlint,

		-- Java
		formatting.google_java_format,

		-- Kotlin
		formatting.ktlint,
		diagnostics.ktlint,

		-- SQL
		diagnostics.sqlfluff.with({
			extra_args = { "--dialect", "postgres" },
		}),

		-- YAML
		diagnostics.yamllint,

		-- ZSH / Shell
		formatting.shfmt.with({
			extra_args = { "-i", "2" },
		}),
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
