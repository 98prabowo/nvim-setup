-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	return
end

saga.setup({
	-- keybinds for navigation in lspsaga window
	scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
	-- use enter to open file with definition preview
	definition = {
		edit = "<CR>",
	},
	ui = {
		colors = {
			normal_bg = "#1D2021",
		},
	},
})

vim.cmd([[
  highlight LspSagaDefPreview guibg=#1D2021
  highlight LspSagaFloatWin guibg=#1D2021
  highlight NormalFloat guibg=#1D2021
]])
