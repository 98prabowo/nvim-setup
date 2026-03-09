local keymap = vim.keymap

-- custom movement
keymap.set("n", "1", "0", { desc = "Move cursor to the first column" })
keymap.set("n", "0", "$", { desc = "Move cursor to the last column" })

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- clear search highlight
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlight" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "Delete a single character" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split window equally width" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split window" })
keymap.set("n", "<leader>w", "<C-w>w", { desc = "Move between window" })

keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })

-- code block movement
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move marked code block up" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move marked code block down" })

-- yank remap
keymap.set("n", "<leader>y", '"+y', { desc = "Copy code in normal mode inside system" })
keymap.set("v", "<leader>y", '"+y', { desc = "Copy code in visul mode inside system" })
keymap.set("n", "<leader>y", '"+Y', { desc = "Copy code in normal mode inside nvim" })

keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace all occurrences of the word under the cursor in the entire file" }
)

-- navigation
keymap.set("n", "<leader>n,", ":bp<CR>", { desc = "Navigate to previous file" })
keymap.set("n", "<leader>n.", ":bn<CR>", { desc = "Navigate to next file" })
