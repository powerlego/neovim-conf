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
}
