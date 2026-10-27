return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        dependencies = {
            "L3MON4D3/LuaSnip",
        },
        opts = {
            keymap = {
                preset = "super-tab",
            },

            completion = {
                keyword = {
                    range = "full",
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                ghost_text = {
                    enabled = true,
                },
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    },
                },
            },

            signature = {
                enabled = true,
            },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
            },

            cmdline = {
                enabled = false,
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
        },

        config = function()
            local lspconfig = require("lspconfig")
            local util = lspconfig.util

            require("fidget").setup({})
            require("mason").setup()

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "pyright",
                    "html",
                    "vtsls",
                    "jsonls",
                    "clangd",
                    "omnisharp",
                    "gopls",
                    "jdtls",
                    "yamlls",

                    "html",
                    "cssls",
                    "vtsls",
                    "astro",
                    "jsonls",
                },

                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,


                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = "LuaJIT",
                                    },
                                    completion = {
                                        callSnippet = "Replace",
                                    },
                                    diagnostics = {
                                        globals = {
                                            "vim",
                                            "bit",
                                            "it",
                                            "describe",
                                            "before_each",
                                            "after_each",
                                        },
                                    },
                                    workspace = {
                                        checkThirdParty = false,
                                        library = {
                                            vim.env.VIMRUNTIME,
                                            vim.api.nvim_get_runtime_file("", true),
                                        },
                                    },
                                    telemetry = {
                                        enable = false,
                                    },
                                },
                            },
                        })
                    end,

                    ["html"] = function()
                        lspconfig.html.setup({
                            capabilities = capabilities,
                            settings = {
                                html = {
                                    format = {
                                        indentInnerHtml = true,
                                    },
                                    hover = {
                                        documentation = true,
                                        references = true,
                                    },
                                },
                            },
                        })
                    end,

                    ["clangd"] = function()
                        lspconfig.clangd.setup({
                            capabilities = capabilities,
                            cmd = {
                                "clangd",
                                "--background-index",
                                "--clang-tidy",
                            },
                            root_dir = util.root_pattern(
                                "compile_commands.json",
                                "compile_flags.txt",
                                "Makefile",
                                "CMakeLists.txt",
                                ".git"
                            ),
                        })
                    end,

                    ["vtsls"] = function()
                        lspconfig.vtsls.setup({
                            capabilities = capabilities,
                            root_dir = util.root_pattern(
                                "package.json",
                                "tsconfig.json",
                                "jsconfig.json",
                                ".git"
                            ),
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
                                    suggest = {
                                        completeFunctionCalls = true,
                                    },
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
                                    suggest = {
                                        completeFunctionCalls = true,
                                    },
                                },
                            },
                        })
                    end,

                    ["jsonls"] = function()
                        lspconfig.jsonls.setup({
                            capabilities = capabilities,
                            settings = {
                                json = {
                                    validate = {
                                        enable = true,
                                    },
                                },
                            },
                        })
                    end,

                    ["pyright"] = function()
                        lspconfig.pyright.setup({
                            capabilities = capabilities,
                        })
                    end,

                    ["rust_analyzer"] = function()
                        lspconfig.rust_analyzer.setup({
                            capabilities = capabilities,
                            settings = {
                                ["rust-analyzer"] = {
                                    checkOnSave = true,
                                },
                            },
                        })
                    end,

                    ["omnisharp"] = function()
                        lspconfig.omnisharp.setup({
                            capabilities = capabilities,
                            cmd = {
                                "omnisharp",
                            },
                            enable_roslyn_analyzers = true,
                            organise_imports_on_format = true,
                            enable_import_completion = true,
                        })
                    end,

                    ["gopls"] = function()
                        lspconfig.gopls.setup({
                            capabilities = capabilities,
                            settings = {
                                gopls = {
                                    analyses = {
                                        unusedparams = true,
                                        shadow = true,
                                    },
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
                        })
                    end,

                    ["zls"] = function()
                        lspconfig.zls.setup({
                            capabilities = capabilities,
                            root_dir = util.root_pattern(
                                ".git",
                                "build.zig",
                                "zls.json"
                            ),
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
                },
            })

            -- sourcekit-lsp is bundled with Xcode / the Swift toolchain rather
            -- than being installable through Mason, so it's configured
            -- directly via lspconfig instead of through mason-lspconfig's
            -- handlers table above.
            lspconfig.sourcekit.setup({
                capabilities = capabilities,
                cmd = {
                    "xcrun",
                    "sourcekit-lsp",
                },
                filetypes = {
                    "swift",
                    "objective-c",
                    "objective-cpp",
                },
                root_dir = util.root_pattern(
                    "Package.swift",
                    ".git"
                ),
            })

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
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
    },
}
