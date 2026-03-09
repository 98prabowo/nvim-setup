local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	-- Library & Icons
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",

	-- UI & Appearance
	"ellisonleao/gruvbox.nvim",
	"szw/vim-maximizer",
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("98prabowo.plugins.lualine")
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("98prabowo.plugins.dashboard")
		end,
	},
	{
		"mbbill/undotree",
		config = function()
			require("98prabowo.plugins.undotree")
		end,
	},

	-- Navigation & Utils
	"christoomey/vim-tmux-navigator",
	"tpope/vim-surround",
	"vim-scripts/ReplaceWithRegister",
	{
		"numToStr/Comment.nvim",
		config = function()
			require("98prabowo.plugins.comment")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("98prabowo.plugins.nvim-tree")
		end,
	},

	-- Search (Telescope)
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("98prabowo.plugins.telescope")
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("98prabowo.plugins.treesitter")
		end,
	},

	-- LSP Management
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-null-ls.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			require("98prabowo.lsp.mason")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("98prabowo.lsp.lspconfig")
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("98prabowo.lsp.lspsaga")
		end,
	},
	"lvimuser/lsp-inlayhints.nvim",

	-- Autocompletion & Snippets
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("98prabowo.plugins.nvim-cmp")
		end,
	},

	-- Formatting & Linting (None-ls)
	{
		"nvimtools/none-ls.nvim",
		config = function()
			require("98prabowo.lsp.none-ls")
		end,
	},

	-- Debugger (DAP)
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio", -- Diperlukan oleh dap-ui terbaru
			"williamboman/mason.nvim",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			-- Lazy menjamin dap & dapui sudah ada sebelum baris ini dijalankan
			require("98prabowo.lsp.dap")
		end,
	},

	-- Programming Languages Specific
	{
		"Saecki/crates.nvim",
		tag = "stable",
		config = function()
			require("98prabowo.plugins.crates")
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("98prabowo.plugins.todo-comment")
		end,
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("98prabowo.plugins.gitsign")
		end,
	},
	"tpope/vim-fugitive",

	-- Automation
	{
		"windwp/nvim-autopairs",
		config = function()
			require("98prabowo.plugins.autopairs")
		end,
	},

	-- Leetcode
	{
		"kawre/leetcode.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			require("98prabowo.plugins.leetcode")
		end,
	},

	-- -- Configure any other settings here. See the documentation for more details.
	-- -- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
