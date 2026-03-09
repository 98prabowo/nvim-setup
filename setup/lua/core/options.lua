local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentations
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
-- opt.backgrougnd = "dark"
opt.signcolumn = "yes"

-- update time (ms) - default to 4000
opt.updatetime = 750

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- disable neovim
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = vim.fn.system("pyenv which python3"):gsub("%s+", "")
vim.g.ruby_host_prog = os.getenv("HOME") .. "/.rbenv/shims/ruby"
