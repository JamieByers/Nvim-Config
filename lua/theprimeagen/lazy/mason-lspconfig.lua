return {
    "williamboman/mason-lspconfig.nvim",
    version = "v2.0.0",
    config = function()
        require("mason-lspconfig").setup()
    end,
}
