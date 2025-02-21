return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "rouge8/neotest-rust",
    },

    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                    args = {"--log-level", "DEBUG"},
                    runner = "pytest",
                    python = ".venv/bin/python",
                    pytest_discover_instances = true,
                }),
                require("neotest-rust")({
                    args = { "--no-capture" },
                    dap_adapter = "lldb",
                })
            }
        })
    end
}

