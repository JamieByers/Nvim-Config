return {
    "williamboman/mason-lspconfig.nvim",
    version = "v1.*",
    config = function()
        require("mason-lspconfig").setup()
    end,
}
