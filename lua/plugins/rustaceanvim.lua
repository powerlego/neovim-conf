local rustfmt = require("config/rustfmt").location

return {
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
}
