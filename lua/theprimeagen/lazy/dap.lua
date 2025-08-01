return {
    { "nvim-neotest/nvim-nio" },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "python", "cppdbg", "codelldb" },
                automatic_installation = true,
            })
        end
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = { "williamboman/mason.nvim", "jay-babu/mason-nvim-dap.nvim" },
        config = function()
            local dap = require("dap")

            dap.adapters.lldb = {
                type = "executable",
                command = "/usr/bin/lldb-vscode",
                name = "lldb",
            }

            dap.configurations.rust = {
                {
                    name = "Launch",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }

      -- Keybindings for Debugging
      vim.keymap.set("n", "<leader>dbs", function() dap.continue() end, { desc = "Start/Continue Debugging" })
      vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Step Over" })
      vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Step Into" })
      vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Step Out" })
      vim.keymap.set("n", "<Leader>b", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<Leader>B", function() dap.set_breakpoint() end, { desc = "Set Breakpoint with Condition" })
    end
  }
}

