return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "Saghen/blink.cmp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "supermaven-inc/supermaven-nvim",
    },

    config = function()
        -- Use blink.cmp capabilities instead of nvim-cmp
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "pyright",
                "gopls",
                "html",
                "vtsls",
                "jsonls",
                "clangd",
                "omnisharp",
                "csharp_ls",
            },
        })

        local lspconfig = require("lspconfig")

        require("mason-lspconfig").setup_handlers({
            function(server_name)
                lspconfig[server_name].setup {
                    capabilities = capabilities,
                }
            end,

            zls = function()
                lspconfig.zls.setup({
                    capabilities = capabilities,
                    root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                    settings = {
                        zls = {
                            enable_inlay_hints = true,
                            enable_snippets = true,
                            warn_style = true,
                        },
                    },
                })
                vim.g.zig_fmt_parse_errors = 0
                vim.g.zig_fmt_autosave = 0
            end,

            lua_ls = function()
                lspconfig.lua_ls.setup {
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            runtime = { version = "Lua 5.1" },
                            diagnostics = {
                                globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                            },
                        },
                    },
                }
            end,

            html = function()
                lspconfig.html.setup {
                    capabilities = capabilities,
                    settings = {
                        html = {
                            format = { indentInnerHtml = true },
                            hover = { documentation = true, references = true },
                        },
                    },
                }
            end,

            clangd = function()
                lspconfig.clangd.setup({
                    capabilities = capabilities,
                    cmd = { "clangd", "--background-index", "--clang-tidy" },
                    root_dir = lspconfig.util.root_pattern(".git", "compile_commands.json", "compile_flags.txt", "Makefile"),
                })
            end,

            csharp_ls = function()
                lspconfig.csharp_ls.setup({
                    capabilities = capabilities,
                    cmd = { "csharp-ls" },
                    filetypes = { "cs" },
                    root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
                })
            end,

            vtsls = function()
                lspconfig.vtsls.setup({
                    capabilities = capabilities,
                    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
                    settings = {
                        typescript = {
                            inlayHints = {
                                parameterNames = { enabled = "all" },
                                parameterTypes = { enabled = true },
                                variableTypes = { enabled = true },
                                propertyDeclarationTypes = { enabled = true },
                                functionLikeReturnTypes = { enabled = true },
                                enumMemberValues = { enabled = true },
                            },
                            suggest = { completeFunctionCalls = true },
                        },
                        javascript = {
                            inlayHints = {
                                parameterNames = { enabled = "all" },
                                parameterTypes = { enabled = true },
                                variableTypes = { enabled = true },
                                propertyDeclarationTypes = { enabled = true },
                                functionLikeReturnTypes = { enabled = true },
                                enumMemberValues = { enabled = true },
                            },
                            suggest = { completeFunctionCalls = true },
                        },
                    },
                })
            end,

            jsonls = function()
                lspconfig.jsonls.setup({
                    capabilities = capabilities,
                    settings = {
                        json = { validate = { enable = true } },
                    },
                })
            end,

            omnisharp = function()
                lspconfig.omnisharp.setup({
                    capabilities = capabilities,
                    cmd = { "omnisharp" },
                    enable_roslyn_analyzers = true,
                    organise_imports_on_format = true,
                    enable_import_completion = true,
                })
            end,

            pyright = function()
                lspconfig.pyright.setup {
                    capabilities = capabilities,
                }
            end,

            gopls = function()
                lspconfig.gopls.setup {
                    capabilities = capabilities,
                    settings = {
                        gopls = {
                            analyses = { unusedparams = true, shadow = true },
                            staticcheck = true,
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                        },
                    },
                }
            end,
        })

        -- Configure blink.cmp
        require('blink.cmp').setup({
            completion = {
                keyword = { range = 'full' },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                ghost_text = {
                    enabled = true,
                },
                list = {
                    selection = { auto_insert = true },
                },
            },

            signature = { enabled = true },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            keymap = {
                preset = "super-tab",
            },
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
