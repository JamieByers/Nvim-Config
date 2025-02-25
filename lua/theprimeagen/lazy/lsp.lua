return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "Saghen/blink.cmp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "pyright",
                "gopls",
                "html"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
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
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,

                ["html"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.html.setup {
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
                            }
                        }
                    }
                end,

                -- Add a handler for Pyright
                ["pyright"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup {
                        capabilities = capabilities,
                    }
                end,
                ["gopls"] = function()
                local lspconfig = require("lspconfig")
                lspconfig.gopls.setup {
                    capabilities = capabilities,
                    settings = {
                        gopls = {
                            -- Optional: Configure Go-specific LSP settings
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
                            }
                        }
                    }
                }
            end,
            }
        })

        -- nvim-cmp completion
        -- local cmp = require('cmp')
        -- local cmp_select = { behavior = cmp.SelectBehavior.Select }

        -- cmp.setup({
        --     snippet = {
        --         expand = function(args)
        --             require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        --         end,
        --     },
        --     mapping = cmp.mapping.preset.insert({
        --         ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        --         ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        --         ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        --         ["<C-Space>"] = cmp.mapping.complete(),
        --     }),
        --     sources = cmp.config.sources({
        --         { name = 'nvim_lsp' },
        --         { name = 'luasnip' }, -- For luasnip users.
        --     }, {
        --         { name = 'buffer' },
        --     })
        -- })
        --

        -- blink.cmp configuration
        local cmp = require('blink.cmp')
        cmp.setup({
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

            cmdline = {
                enabled = false,
            },


        })

        vim.diagnostic.config({
            -- update_in_insert = true,
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
