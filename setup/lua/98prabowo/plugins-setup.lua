local fn = vim.fn

-- Automatically install packer
local ensure_packer = function()
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- Auto command that reloads neovim whenever you save this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")

if not status then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- lua functions that many plugins use
	use("nvim-lua/plenary.nvim")

	-- colorscheme
	use("ellisonleao/gruvbox.nvim")

	-- tmux & split window navigation
	use("christoomey/vim-tmux-navigator")

	-- Maximizes and restores current window
	use("szw/vim-maximizer")

	-- Essential plugins
	use("tpope/vim-surround")
	use("vim-scripts/ReplaceWithRegister")

	-- Commenting with gc
	use("numToStr/Comment.nvim")

	-- File explorer
	use("nvim-tree/nvim-tree.lua")

	-- Dashboard
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	-- VScode like icons
	use("nvim-tree/nvim-web-devicons")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { { "nvim-lua/plenary.nvim" } } }) -- fuzzy finder

	-- undo history tree
	use("mbbill/undotree")

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use({ "L3MON4D3/LuaSnip", build = "make install_jsregexp" }) -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use("mason-org/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("mason-org/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"nvimdev/lspsaga.nvim",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}) -- enhanced lsp uis
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
	use("lvimuser/lsp-inlayhints.nvim") -- inline hint

	-- cargo crates helper
	use({
		"Saecki/crates.nvim",
		tag = "stable",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- highlight comment mark
	use({
		"folke/todo-comments.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- formatting & linting
	use("nvimtools/none-ls.nvim") -- configure formatters & linters
	use("jay-babu/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- debugger
	use({ "mfussenegger/nvim-dap" })
	use({
		"rcarriga/nvim-dap-ui",
		requires = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
	})
	use({
		"jay-babu/mason-nvim-dap.nvim",
		requires = { "williamboman/mason.nvim" },
	})
	use({
		"nvim-telescope/telescope-dap.nvim",
		requires = { "mfussenegger/nvim-dap" },
	})

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
	use("tpope/vim-fugitive") -- git command helper

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the :PackerCompile end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
