-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- custom movement
keymap.set("n", "1", "0")
keymap.set("n", "0", "$")

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlight
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split window equally width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window
keymap.set("n", "<leader>w", "<C-w>w") -- move between window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

-- code block movement
keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move marked code block up
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move marked code block down

-- yank remap
keymap.set("n", "<leader>y", '"+y') -- copy code in normal mode inside system
keymap.set("v", "<leader>y", '"+y') -- copy code in visul mode inside system
keymap.set("n", "<leader>y", '"+Y') -- copy code in normal mode inside nvim

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- navigation
keymap.set("n", "<leader>bn", ":bn<CR>")
keymap.set("n", "<leader>bp", ":bp<CR>")

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- dashboard (alpha)
keymap.set("n", "<leader>bd", ":bufdo bd | lua require('alpha').start()<CR>", { noremap = true, silent = true })

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

keymap.set("v", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
