local map = vim.keymap.set

map({ "n", "v" }, "<F1>", function()
	require("dap").continue()
end, { desc = "Debug: Start/Continue" })

map({ "n", "v" }, "<F25>", function()
	require("dap").run_last()
end, { desc = "Debug: Run Last Configuration" })

map({ "n", "v" }, "<F3>", function()
	require("dap").step_over()
end, { desc = "Debug: Step Over" })

map({ "n", "v" }, "<F4>", function()
	require("dap").step_into()
end, { desc = "Debug: Step Into" })

map({ "n", "v" }, "<F28>", function()
	require("dap").step_out()
end, { desc = "Debug: Step Out" })

map({ "n", "v" }, "<F2>", function()
	require("dap").toggle_breakpoint()
end, { desc = "Debug: Toggle Breakpoint" })

map({ "n", "v" }, "<F26>", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set Conditional Breakpoint" })

map({ "n", "v" }, "<F9>", function()
	require("dapui").toggle()
end, { desc = "Debug: Toggle UI" })
