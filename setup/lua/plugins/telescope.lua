return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"folke/todo-comments.nvim",
		"mfussenegger/nvim-dap",
	},
	cmd = "Telescope",
	keys = {
		-- Telescope
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files (respect .gitignore)" },
		{ "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Find string (live grep)" },
		{ "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List open buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "List help tags" },
		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Search TODOs" },
		{ "<leader>fd", "<cmd>DapBreakpoints<cr>", desc = "List active breakpoints" },

		-- Telescope git
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "List git commits" },
		{ "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", desc = "List git file commits" },
		{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "List git branches" },
		{ "<leader>gt", "<cmd>Telescope git_status<cr>", desc = "List git status" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				layout_config = {
					width = 0.75,
					prompt_position = "top",
					preview_cutoff = 120,
					horizontal = { mirror = false },
					vertical = { mirror = false },
				},

				find_command = {
					"rg",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},

				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },

				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "descending",
				layout_strategy = "horizontal",
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				file_ignore_patterns = {},
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,

				winblend = 0,
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				use_less = true,
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,

				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
						["<esc>"] = actions.close,
						["<CR>"] = actions.select_default + actions.center,
					},
					n = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "todo-comments")
		pcall(telescope.load_extension, "dap")

		vim.api.nvim_create_user_command("DapBreakpoints", function()
			local ok, _ = pcall(require, "telescope._extensions.dap")
			if ok then
				telescope.extensions.dap.list_breakpoints()
			else
				vim.notify("Telescope DAP extension not loaded", vim.log.levels.WARN)
			end
		end, {})
	end,
}
