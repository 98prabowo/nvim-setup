return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- Need for dapui
		"williamboman/mason.nvim",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

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

		-- Continue & Terminate
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
		vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "DAP Terminate" })

		-- Step Controls
		vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "DAP Step Over" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP Step Into" })
		vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "DAP Step Out" })

		-- Breakpoints
		vim.keymap.set("n", "<leader>bn", dap.set_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>bc", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Conditional Breakpoint" })
		vim.keymap.set("n", "<leader>bl", function()
			print(vim.inspect(require("dap").list_breakpoints()))
		end, { desc = "Print DAP Breakpoints" })

		-- UI Toggle & Eval
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Eval expression" })

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
