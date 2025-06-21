local dap_status, dap = pcall(require, "dap")
if not dap_status then
	vim.notify("DAP not installed", vim.log.levels.WARN)
	return
end

local mason_registry_status, mason_registry = pcall(require, "mason-registry")
if not mason_registry_status then
	vim.notify("Mason registry not installed", vim.log.levels.WARN)
	return
end

local dap_ui_status, dapui = pcall(require, "dapui")
if not dap_ui_status then
	vim.notify("DAP UI not installed", vim.log.levels.WARN)
	return
end

-- local codelldb = mason_registry.get_package("codelldb")
-- local extension_path = codelldb:get_install_path() .. "/extension/"

local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib" -- macOS

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = codelldb_path,
		args = { "--port", "${port}" },
		env = { LLDB_LIBRARY_PATH = liblldb_path },
	},
}

local function get_latest_rust_executable()
	-- Build the project first
	vim.fn.jobstart("cargo build", { stdout_buffered = true, stderr_buffered = true })

	-- Return path to binary
	local target_dir = vim.fn.getcwd() .. "/target/debug"
	local handle = io.popen("ls -tp " .. target_dir .. " | grep -vE '/$|\\.d$|\\.rlib$' | head -n 1")
	if not handle then
		vim.notify("Failed to get latest Rust executable", vim.log.levels.ERROR)
		return nil
	end

	local result = handle:read("*a")
	handle:close()

	result = result and result:gsub("%s+", "")
	if result == "" then
		vim.notify("No valid Rust executable found", vim.log.levels.WARN)
		return nil
	end

	return target_dir .. "/" .. result
end

dap.configurations.rust = {
	{
		name = "Debug executable",
		type = "codelldb",
		request = "launch",
		program = get_latest_rust_executable,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
}

-- DAP UI auto open/close
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Keybindings
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Eval expression" })
