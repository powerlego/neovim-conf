local pick = nil
pick = function()
    return vim.cmd("Telescope file_browser")
end

return {
    {
        "ahmedkhalf/project.nvim",
        dependencies = {
            "nvim-telescope/telescope-file-browser.nvim",
        },
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        init = function()
            require("lazyvim.util").on_load("telescope.nvim", function()
                require("telescope").load_extension("file_browser")
            end)
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        keys = {
            { "<leader>fB", pick, desc = "File Browser" },
        },
    },
}
