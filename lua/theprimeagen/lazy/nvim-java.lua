return {
    "nvim-java/nvim-java",
    dependencies = {
        "nvim-java/lua-async-await",
        "nvim-java/nvim-java-core",
        "nvim-java/nvim-java-test",
        "nvim-java/nvim-java-dap",
        "MunifTanjim/nui.nvim",
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap",
    },
    ft = { "java" },
    config = function()
        require("java").setup({
            jdtls = {
                configuration = {
                    eclipse = {
                        downloadSources = true,
                    },
                },
                inlay_hints = {
                    parameterNames = true,
                },
            },
            dap = {
                hotcodereplace = "auto",
            },
            test = {
                enable = true,
            },
        })
    end,
}

