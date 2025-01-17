local rustfmt = require("config/rustfmt").location

return {
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
        opts = {
            options = {
                cursorline = true,
            },
        },
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "onedark",
        },
    },
    {
        "mrcjkb/rustaceanvim",
        opts = {
            server = {
                default_settings = {
                    -- rust-analyzer language server configuration
                    ["rust-analyzer"] = {
                        rustfmt = {
                            overrideCommand = {
                                rustfmt,
                            },
                        },
                        assist = {
                            emitMustUse = true,
                        },
                        diagnostics = {
                            styleLints = {
                                enable = true,
                            },
                        },
                        completion = {
                            termSearch = {
                                enable = true,
                            },
                        },
                        semanticHighlighting = {
                            operator = {
                                specialization = {
                                    enable = true,
                                },
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = function(_, opts)
            opts.formatters.rustfmt = {
                command = rustfmt,
                args = {
                    "--emit=stdout",
                },
                stdin = true,
            }
            opts.formatters_by_ft["rust"] = opts.formatters_by_ft["rust"] or {}
            table.insert(opts.formatters_by_ft["rust"], "rustfmt")
            opts.formatters_by_ft["rust"].lsp_format = "prefered"
        end,
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "marilari88/neotest-vitest",
        },
        opts = {
            adapters = {
                ["neotest-vitest"] = {},
            },
        },
    },
    {
        "hat0uma/csvview.nvim",
        opts = {
            view = {
                display_mode = "border",
            },
        },
    },
}
