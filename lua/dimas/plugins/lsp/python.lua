vim.g.python3_host_prog = vim.fn.system("pyenv which python3"):gsub("%s+", "")
