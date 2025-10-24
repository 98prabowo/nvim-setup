local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	vim.notify("CMP nvim lsp not installed", vim.log.levels.ERROR)
	return
end

local keymap = vim.keymap

-- enable keybinds for available lsp server
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts) -- see outline on right hand side

	-- rust specific keymaps
	if client.name == "rust_analyzer" then
		keymap.set("n", "<C-space>", vim.lsp.buf.hover, opts) -- Hover actions
		keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, opts) -- Code action groups

		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("RustFormat", { clear = true }),
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end

		if client.supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.config["arduino_language_server"] = {
	cmd = { "arduino_language_server" },
	filetypes = { "arduino" },
	capabilities = capabilities,
	on_attach = on_attach,
}
vim.lsp.enable("arduino_language_server")

vim.lsp.config["bashls"] = {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash" },
	capabilities = capabilities,
	on_attach = on_attach,
}
vim.lsp.enable("bashls")

vim.lsp.config["clangd"] = {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
	capabilities = capabilities,
	on_attach = on_attach,
}
vim.lsp.enable("clangd")

vim.lsp.config["cssls"] = {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	capabilities = capabilities,
	on_attach = on_attach,
}
vim.lsp.enable("cssls")

vim.lsp.config["gopls"] = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	capabilities = capabilities,
	on_attach = on_attach,
}
vim.lsp.enable("gopls")

vim.lsp.config["graphql"] = {
	cmd = { "graphql-lsp", "server", "-m", "stream" },
	filetypes = { "graphql", "typescriptreact", "javascriptreact" },
	capabilities = capabilities,
	on_attach = on_attach,
}
vim.lsp.enable("graphql")

vim.lsp.config["html"] = {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	capabilities = capabilities,
	on_attach = on_attach,
}
vim.lsp.enable("html")

vim.lsp.config["jedi_language_server"] = {
	cmd = { "jedi-language-server" },
	filetypes = { "python" },
	capabilities = capabilities,
	on_attach = on_attach,
}
vim.lsp.enable("jedi_language_server")

vim.lsp.config["jsonls"] = {
	cmd = { "vscode-json-languageserver", "--stdio" },
	filetypes = { "json", "jsonc" },
	capabilities = capabilities,
	on_attach = on_attach,
	single_file_support = true,
}
vim.lsp.enable("jsonls")

vim.lsp.config["lemminx"] = {
	cmd = { "lemminx" },
	filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
	capabilities = capabilities,
	on_attach = on_attach,
}
vim.lsp.enable("lemminx")

vim.lsp.config["rust_analyzer"] = {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
			inlayHints = {
				bindingModeHints = {
					enable = true,
				},
				chainingHints = {
					enable = true,
				},
				closureCaptureHints = {
					enable = true,
				},
				closingBraceHints = {
					enable = true,
					minLines = 250,
				},
				closureReturnTypeHints = {
					enable = true,
				},
				lifetimeElisionHints = {
					enable = "always",
					useParameterNames = true,
				},
				parameterHints = {
					enable = true,
				},
				reborrowHints = {
					enable = "always",
				},
				typeHints = {
					enable = true,
					hideClosureInitialization = false,
					hideNamedConstructor = false,
				},
			},
			check = {
				command = "clippy",
			},
		},
	},
}
vim.lsp.enable("rust_analyzer")

vim.lsp.config["sourcekit"] = {
	cmd = { "sourcekit-lsp" },
	filetypes = { "swift", "objective-c", "objective-cpp" },
	capabilities = capabilities,
	on_attach = on_attach,
}
vim.lsp.enable("sourcekit")

vim.lsp.config["postgres_lsp"] = {
	cmd = { "postgrestools" },
	filetypes = { "sql", "pgsql" },
	capabilities = capabilities,
	on_attach = on_attach,
	root_markers = { ".git", "sql.yml", "pgconfig.toml", "postgrestools.jsonc" },
}
vim.lsp.enable("postgres_lsp")

vim.lsp.config["yamlls"] = {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yml" },
	capabilities = capabilities,
	on_attach = on_attach,
}
vim.lsp.enable("yamlls")

vim.lsp.config["ts_ls"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
	capabilities = capabilities,
	on_attach = on_attach,
	single_file_support = true,
}
vim.lsp.enable("ts_ls")

vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	capabilities = capabilities,
	on_attach = on_attach,
	single_file_support = true,
	settings = {
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
vim.lsp.enable("lua_ls")
