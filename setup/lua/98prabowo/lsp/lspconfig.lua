-- import lspconfi
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- import rust plugin safely
local rust_setup, rust = pcall(require, "rust-tools")
if not rust_setup then
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

lspconfig.arduino_language_server.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.bashls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.clangd.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.graphql.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.jedi_language_server.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.lemminx.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.ltex.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.rust_analyzer.setup({
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
})

lspconfig.sqlls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.yamlls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.ts_ls.setup({
	cmd = { "typescript-language-server", "--stdio" }, -- Explicit command
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),
	capabilities = capabilities,
	on_attach = on_attach,
	single_file_support = true,
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
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
})
