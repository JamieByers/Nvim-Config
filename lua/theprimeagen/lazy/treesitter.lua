
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",

        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },

        config = function()
            require("nvim-treesitter").setup()

            require("nvim-treesitter").install({
                "vimdoc",
                "javascript",
                "typescript",
                "c",
                "cpp",
                "lua",
                "rust",
                "jsdoc",
                "bash",
                "go",
                "java",
                "html",
                "css",
                "json",
                "markdown",
                "markdown_inline",
            })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)

                    vim.wo.foldmethod = "expr"
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

                    vim.bo.indentexpr =
                        "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        config = function()
            require("treesitter-context").setup({
                enable = true,
                multiwindow = false,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 20,
                on_attach = nil,
            })
        end,
    },
}

