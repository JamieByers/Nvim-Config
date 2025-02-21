return {
  {
    "MunifTanjim/prettier.nvim",
    config = function()
      require("prettier").setup({
        bin = 'prettier', -- Use 'prettier' if you don’t have 'prettierd' installed
        filetypes = {
          "javascript",
          "typescript",
          "css",
          "scss",
          "html",
          "json",
          "yaml",
          "markdown",
          "graphql",
        },
      })
    end,
  }
}

