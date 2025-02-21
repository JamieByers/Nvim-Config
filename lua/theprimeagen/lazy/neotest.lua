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


        vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua require('neotest').run.run()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>ent", "<cmd>lua require('neotest').run.stop()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>lua require('neotestr).run.run(vim.fn.expand('%'))<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>dnt", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", { noremap = true, silent = true })
    end
}

