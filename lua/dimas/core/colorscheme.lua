-- import colorscheme nightfly safely
-- local nightfly_status, _ = pcall(vim.cmd, "colorscheme nightfly")
-- if not nightfly_status then
-- 	print("Colorscheme not found!")
-- 	return
-- end

-- local onedark_status, _ = pcall(vim.cmd, "colorscheme onedark")
-- if not onedark_status then
-- 	print("One dark not found!")
-- 	return
-- end
--
-- require("onedark").setup({
-- 	style = "darker",
-- 	transparent = true,
-- 	term_colors = true, -- Change terminal color as per the selected theme style
-- })
--
-- require("onedark").load()

-- local onedark_status, _ = pcall(vim.cmd, "colorscheme catppuccin")
-- if not onedark_status then
-- 	print("Catppuccin not found!")
-- 	return
-- end

local gruvbox_status, gruvbox = pcall(require, "gruvbox")
if not gruvbox_status then
	print("Gruvbox not found!")
	return
end

gruvbox.setup({
	terminal_colors = true, -- add neovim terminal colors
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = true,
		emphasis = true,
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "hard", -- can be "hard", "soft" or empty string
	palette_overrides = {},
	overrides = {},
	dim_inactive = false,
	transparent_mode = false,
})

vim.o.background = "dark"
vim.opt.termguicolors = true
vim.cmd("colorscheme gruvbox")
