-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

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

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace all occurrences of the word under the cursor in the entire file" })

-- navigation
keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Navigate to next file" })
keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "Navigate to previous file" })

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- dashboard (alpha)
keymap.set("n", "<leader>bd", ":bufdo bd | lua require('alpha').start()<CR>", { noremap = true, silent = true, desc = "Navigate to dashboard" })

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Open file explorer" })

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files within current working directory, respects .gitignore" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in current working directory as you type" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in current working directory" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List open buffers in current neovim instance" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "List available help tags" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Search TODOs with Telescope" })

-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "List all git commits (use <cr> to checkout) [\"gc\" for git commits]" })
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", { desc = "List git commits for current file/buffer (use <cr> to checkout) [\"gfc\" for git file commits]" })
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "List git branches (use <cr> to checkout) [\"gb\" for git branch]" })
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "List current changes per file with diff preview [\"gs\" for git status]" })

-- tmux
keymap.set("v", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open tmux sessionizer" })
