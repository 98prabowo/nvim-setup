-- import harpoon mark safely
local mark_status, mark = pcall(require, "harpoon.mark")
if not mark_status then
	return
end

-- import harpoon ui safely
local ui_status, ui = pcall(require, "harpoon.ui")
if not ui_status then
	return
end

-- keybinds for harpoon
local keymap = vim.keymap

keymap.set("n", "<leader>a", mark.add_file)
keymap.set("n", "<C-e>", ui.toggle_quick_menu)

keymap.set("n", "<C-y>", function()
	ui.nav_file(1)
end)
keymap.set("n", "<C-t>", function()
	ui.nav_file(2)
end)
keymap.set("n", "<C-n>", function()
	ui.nav_file(3)
end)
keymap.set("n", "<C-s>", function()
	ui.nav_file(4)
end)
