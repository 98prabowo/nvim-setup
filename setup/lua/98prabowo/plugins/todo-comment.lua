local setup, todo = pcall(require, "todo-comments")
if not setup then
	return
end

-- Keybind setup

vim.keymap.set("n", "]t", function()
	todo.jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	todo.jump_prev()
end, { desc = "Previous todo comment" })

-- Color setup

local gruvbox_color = {
	white = "#EBDBB2",
	black = "#1D2021",
	red = "#FB4934",
	green = "#B8BB26",
	yellow = "#FABD2F",
	blue = "#83A598",
	purple = "#D3869B",
	aqua = "#8EC07C",
	orange = "#FE8019",
	gray = "#928374",
}

local highlights = {
	ERROR = { name = "TodoError", fg = gruvbox_color.red, bg = gruvbox_color.black },
	INFO = { name = "TodoInfo", fg = gruvbox_color.blue, bg = gruvbox_color.black },
	HACK = { name = "TodoHack", fg = gruvbox_color.orange, bg = gruvbox_color.black },
	WARN = { name = "TodoWarn", fg = gruvbox_color.yellow, bg = gruvbox_color.black },
	PERF = { name = "TodoPerf", fg = gruvbox_color.purple, bg = gruvbox_color.black },
	HINT = { name = "TodoHint", fg = gruvbox_color.aqua, bg = gruvbox_color.black },
	TEST = { name = "TodoTest", fg = gruvbox_color.green, bg = gruvbox_color.black },
}

for _, data in pairs(highlights) do
	vim.cmd(string.format("highlight %s guibg=%s guifg=%s gui=bold", data.name, data.bg, data.fg))
end

todo.setup({
	keywords = {
		FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "hack" },
		WARN = { icon = " ", color = "warn", alt = { "WARNING", "XXX" } },
		PERF = { icon = "⚡", color = "perf", alt = { "PERFORMANCE", "OPTIM", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
	},
	colors = {
		error = { "TodoError" },
		info = { "TodoInfo" },
		hack = { "TodoHack" },
		warn = { "TodoWarn" },
		perf = { "TodoPerf" },
		hint = { "TodoHint" },
		test = { "TodoTest" },
	},
	highlight = {
		keyword = "wide_bg",
		after = "fg",
		before = "",
		pattern = [[.*<(KEYWORDS)\s*]],
	},
	gui_style = {
		fg = "NONE",
		bg = "BOLD",
	},
})
