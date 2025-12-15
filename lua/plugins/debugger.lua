if true then
	return {}
end
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",

		"nvim-neotest/nvim-nio",

		"mfussenegger/nvim-jdtls",

		"theHamsta/nvim-dap-virtual-text",
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Dap UI setup
		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_over = "↷",
					step_into = "↓",
					step_out = "↑",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		-- Automatically open/close DAP UI
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Setup virtual text to show variable values inline
		require("nvim-dap-virtual-text").setup({})

		-- JavaScript / TypeScript debugging (vscode-js-debug)
		local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",

			executable = {
				command = "node",

				args = {
					mason_path .. "/js-debug/src/dapDebugServer.js",
					"${port}",
				},
			},
		}

		-- JS/TS config
		for _, lang in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
			dap.configurations[lang] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch current file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
				},

				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to process",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},

				{
					type = "pwa-node",
					request = "launch",
					name = "npm start",
					runtimeExecutable = "npm",
					runtimeArgs = { "run", "start" },
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					sourceMaps = true,
				},
			}
		end
	end,
}
