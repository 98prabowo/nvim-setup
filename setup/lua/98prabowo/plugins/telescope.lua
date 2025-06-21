local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	vim.notify("telescope not installed", vim.log.levels.ERROR)
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	vim.notify("telescope.actions not installed", vim.log.levels.ERROR)
	return
end

telescope.setup({
	-- configure custom mappings
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

telescope.load_extension("todo-comments")
telescope.load_extension("dap")

vim.api.nvim_create_user_command("DapBreakpoints", function()
	telescope.extensions.dap.list_breakpoints()
end, {})
