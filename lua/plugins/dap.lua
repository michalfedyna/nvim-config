return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
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

		local mason_root = vim.fs.joinpath(vim.fn.stdpath("data"), "mason")
		local mason_bin = vim.fs.joinpath(mason_root, "bin")

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					vim.fs.joinpath(mason_root, "packages", "js-debug-adapter", "js-debug", "src", "dapDebugServer.js"),
					"${port}",
				},
			},
		}


		dap.adapters.mix_task = {
			type = "executable",
			command = vim.fs.joinpath(mason_bin, "elixir-ls-debugger"),
			args = {},
		}
		dap.adapters.erlang_edb = {
			type = "executable",
			command = vim.fs.joinpath(mason_bin, "edb"),
			args = { "dap" },
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
				command = vim.fs.joinpath(mason_root, "packages", "codelldb", "extension", "adapter", "codelldb"),
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

		dap.configurations.elixir = {
			{
				type = "mix_task",
				request = "launch",
				name = "Elixir: mix test",
				task = "test",
				taskArgs = { "--trace" },
				startApps = true,
				projectDir = "${workspaceFolder}",
				requireFiles = {
					"test/**/test_helper.exs",
					"test/**/*_test.exs",
				},
			},
			{
				type = "mix_task",
				request = "launch",
				name = "Elixir: phx.server",
				task = "phx.server",
				projectDir = "${workspaceFolder}",
				debugAutoInterpretAllModules = false,
				debugInterpretModulesPatterns = function()
					local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
					local module = project:gsub("[-_](%w)", string.upper):gsub("^%l", string.upper)
					local input = vim.fn.input("Phoenix module patterns: ", module .. "*, " .. module .. "Web*")
					return vim.tbl_map(vim.trim, vim.split(input, ",", { plain = true, trimempty = true }))
				end,
				exitAfterTaskReturns = false,
			},
		}

		dap.configurations.erlang = {
			{
				type = "erlang_edb",
				request = "launch",
				name = "Erlang: launch rebar3 shell",
				runInTerminal = {
					kind = "integrated",
					title = "rebar3 shell",
					cwd = "${workspaceFolder}",
					args = {
						"sh",
						"-c",
						'exec $0 "$@" --eval="$EDB_DAP_DEBUGGEE_INIT"',
						"rebar3",
						"as",
						"test",
						"shell",
					},
				},
				config = {
					nameDomain = "shortnames",
					nodeInitCodeInEnvVar = "EDB_DAP_DEBUGGEE_INIT",
					timeout = 300,
				},
			},
			{
				type = "erlang_edb",
				request = "attach",
				name = "Erlang: attach to node",
				config = function()
					local node = vim.fn.input("Erlang node: ", "devel@localhost")
					if node == "" then
						return dap.ABORT
					end
					local config = {
						node = node,
						cwd = vim.fn.getcwd(),
					}
					local cookie = vim.fn.inputsecret("Erlang cookie (optional): ")
					if cookie ~= "" then
						config.cookie = cookie
					end
					return config
				end,
			},
		}
	end,
}
