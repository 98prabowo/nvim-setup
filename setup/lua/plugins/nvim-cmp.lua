return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter", -- only load when editing
	dependencies = {
		"hrsh7th/cmp-buffer", -- sources for text in buffer
		"hrsh7th/cmp-path", -- sources for file system paths
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- bridge cmp & luasnip
		"rafamadriz/friendly-snippets", -- vscode snippets collection
		"onsails/lspkind.nvim", -- vscode icon at completion menu
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- load vs-code like snippets from pluggins (e.g friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- basic Neovim configuration for completion
		vim.opt.completeopt = "menu,menuone,noselect"

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- lsp
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
			-- configure lspkind for vs-code like icons
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}
