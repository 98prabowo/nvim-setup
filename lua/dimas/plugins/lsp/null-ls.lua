-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- for conciseness
local action = null_ls.builtins.code_actions -- to setup code actions
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local completion = null_ls.builtins.completion -- to setup code completion

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
		formatting.prettier, -- js/ts formatter
		formatting.stylua, -- lua formatter
		-- diagnostics.eslint_d.with({ -- js/ts linter
		-- 	-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
		-- 	condition = function(utils)
		-- 		return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
		-- 	end,
		-- }),
		formatting.fixjson, -- a JSON file fixer/formatter for humans using (relaxed) JSON5
		diagnostics.pylint, -- python static code analysis tool which looks for programming errors, helps enforcing a coding standard, sniffs for code smells and offers simple refactoring suggestions
		formatting.isort, -- python utility / library to sort imports alphabetically and automatically separate them into sections and by type
		formatting.black, -- the uncompromising Python code formatter
		diagnostics.sqlfluff.with({ -- a SQL linter and auto-formatter for Humans
			extra_args = { "--dialect", "postgres" }, -- change to your dialect
		}),
		diagnostics.yamllint, -- linter for YAML file
		formatting.clang_format, -- tool to format C/C++/C#/Java/Cuda code according to a set of rules and heuristics

		diagnostics.golangci_lint, -- a Go linter aggregator
		formatting.gofmt, -- Formats go programs
		formatting.goimports, -- Updates your Go import lines, adding missing ones and removing unreferenced ones
		formatting.goimports_reviser, -- Tool for Golang to sort goimports by 3 groups: std, general, and project dependencies
		action.impl, -- impl generates method stubs for implementing an interface for golang.

		diagnostics.swiftlint, -- a tool to enforce Swift style and convention
		formatting.swiftformat, -- SwiftFormat is a code library and command-line tool for reformatting swift code on macOS or Linux.
		diagnostics.zsh, -- Uses zsh's own -n option to evaluate, but not execute, zsh scripts. Effectively, this acts somewhat like a linter, although it only really checks for serious errors - and will likely only show the first error.
		-- formatting.rustfmt, -- A tool for formatting rust code according to style guidelines.
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
