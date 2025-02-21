return {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- Add Go formatters here
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.goimports,
            },
        })
    end,
}

