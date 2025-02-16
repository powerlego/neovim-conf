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
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            disabled_keys = {
                ["<Up>"] = { "n", "i" },
                ["<Down>"] = { "n", "i" },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        -- other settings removed for brevity
        opts = {
            setup = {
                eslint = function()
                    local function get_client(buf)
                        return require("lazyvim.util.lsp").get_clients({ name = "eslint", bufnr = buf })[1]
                    end

                    local formatter = require("lazyvim.util.lsp").formatter({
                        name = "eslint: lsp",
                        primary = false,
                        priority = 200,
                        filter = "eslint",
                    })
                    formatter.sources = function(buf)
                        local client = get_client(buf)
                        return client and { "eslint" } or {}
                    end
                    formatter.format = function(buf)
                        -- local client = get_client(buf)
                        -- if client then
                        --     local diag =
                        --         vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                        --     print(#diag > 0)
                        --     if #diag > 0 then
                        vim.cmd("EslintFixAll")
                        -- end
                        -- end
                    end

                    -- register the formatter with LazyVim
                    require("lazyvim.util.format").register(formatter)
                end,
            },
        },
    },
    {
        "folke/snacks.nvim",
        keys = {
            {
                "<leader>fp",
                function()
                    Snacks.picker.projects({
                        patterns = { "package.json", "Makefile", "Cargo.toml", "CMakeLists.txt", "requirements.txt" },
                    })
                end,
                desc = "Projects",
            },
        },
    },
    {
        "folke/snacks.nvim",
        opts = function(_, opts)
            if opts.dashboard.preset.keys[3] ~= nil and opts.dashboard.preset.keys[3].desc == "Projects" then
                opts.dashboard.preset.keys[3] = {
                    icon = " ",
                    key = "p",
                    desc = "Projects",
                    action = ':lua Snacks.picker.projects({patterns = { "package.json", "Makefile", "Cargo.toml", "CMakeLists.txt", "requirements.txt" }})',
                }
            else
                table.insert(opts.dashboard.preset.keys, 3, {
                    icon = " ",
                    key = "p",
                    desc = "Projects",
                    action = ':lua Snacks.picker.projects({patterns = { "package.json", "Makefile", "Cargo.toml", "CMakeLists.txt", "requirements.txt" }})',
                })
            end
        end,
    },
}
