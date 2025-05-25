local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Customize header ASCII art or text
dashboard.section.header.val = {
	"                                               ",
	" ██████╗ ██╗███╗   ███╗██╗   ██╗██╗███╗   ███╗ ",
	" ██╔══██╗██║████╗ ████║██║   ██║██║████╗ ████║ ",
	" ██║  ██║██║██╔████╔██║██║   ██║██║██╔████╔██║ ",
	" ██║  ██║██║██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	" ██████╔╝██║██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	" ╚═════╝ ╚═╝╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
	"           Neovim by Dimas Prabowo             ",
}

-- Buttons
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
	dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
	dashboard.button("s", "  Search text", ":Telescope live_grep <CR>"),
	dashboard.button("e", "  Explore", ":NvimTreeToggle .<CR>"),
	dashboard.button("c", "  Config", ":NvimTreeToggle ~/.config/nvim<CR>"),
	dashboard.button("u", "  Update plugins", ":PackerSync<CR>"),
	dashboard.button("h", "  Check Health", ":checkhealth<CR>"),
	dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- Apply AlphaShortcut to button shortcuts
for _, btn in ipairs(dashboard.section.buttons.val) do
	btn.opts.hl = "AlphaButtons"
	btn.opts.hl_shortcut = "AlphaShortcut"
end

-- Footer
dashboard.section.footer.val = {
	"“Any fool can write code that a computer can understand.",
	"Good programmers write code that humans can understand.”",
	"                                       – Marting Fowler ",
}

-- Use layout to center everything better
dashboard.config.layout = {
	{ type = "padding", val = 8 }, -- space before header
	dashboard.section.header,
	{ type = "padding", val = 2 }, -- space before buttons
	dashboard.section.buttons,
	{ type = "padding", val = 0 },
	dashboard.section.footer,
	{ type = "padding", val = 20 },
}

-- Use your gruvbox colors
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

-- Custom highlights
vim.api.nvim_set_hl(0, "AlphaHeader", { fg = gruvbox_color.orange, bg = gruvbox_color.black, bold = true })
vim.api.nvim_set_hl(0, "AlphaButtons", { fg = gruvbox_color.blue, bg = gruvbox_color.black })
vim.api.nvim_set_hl(0, "AlphaFooter", { fg = gruvbox_color.purple, bg = gruvbox_color.blackj, italic = true })
vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = gruvbox_color.yellow, bg = gruvbox_color.black, bold = true })

-- Apply highlights
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"

alpha.setup(dashboard.config)
