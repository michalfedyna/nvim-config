return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
	config = function()
		require("dapui").setup()
		require("nvim-dap-virtual-text").setup({})

		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					"/Users/fedyna/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
					"${port}",
				},
			},
		}

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "●", texthl = "DiagnosticWarn", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticOk", linehl = "DiffAdd", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "○", texthl = "DiagnosticError", linehl = "", numhl = "" }
		)

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "/Users/fedyna/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
				args = { "--port", "${port}" },
			},
		}
		--cmake -B build -DCMAKE_BUILD_TYPE=Debug
		--cmake --build build
		--Then open a source file, <leader>p for breakpoint, <leader>tc and pick "Launch CMake Debug target".
		local c_configs = {
			{
				type = "codelldb",
				request = "launch",
				name = "Launch (pick executable)",
				program = function()
					return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/build/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
			{
				type = "codelldb",
				request = "launch",
				name = "Launch CMake Debug target",
				program = function()
					local build_dir = vim.fn.getcwd() .. "/build"
					local cmd = "find "
						.. build_dir
						.. " -maxdepth 3 -type f -perm +111 -not -name '*.so' -not -name '*.dylib' -not -path '*/CMakeFiles/*' 2>/dev/null"
					local handle = io.popen(cmd)
					if not handle then
						return vim.fn.input("Executable: ", build_dir .. "/", "file")
					end
					local executables = {}
					for line in handle:lines() do
						table.insert(executables, line)
					end
					handle:close()
					if #executables == 0 then
						return vim.fn.input("Executable: ", build_dir .. "/", "file")
					end
					if #executables == 1 then
						return executables[1]
					end
					local choices = {}
					for i, exe in ipairs(executables) do
						table.insert(choices, i .. ": " .. exe:sub(#build_dir + 2))
					end
					local choice = vim.fn.inputlist(choices)
					if choice < 1 or choice > #executables then
						return nil
					end
					return executables[choice]
				end,
				cwd = "${workspaceFolder}",
			},
			{
				type = "codelldb",
				request = "attach",
				name = "Attach to process",
				pid = require("dap.utils").pick_process,
			},
		}

		for _, ft in ipairs({ "c", "cpp" }) do
			dap.configurations[ft] = c_configs
		end

		local js_based_configs = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach to process",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
		}

		for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
			dap.configurations[ft] = js_based_configs
		end
	end,
}
