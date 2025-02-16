-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local global_local = {
    autoindent = true,
    autoread = true,
    concealcursor = "niv",
    diffopt = "filler,iwhite,internal,linematch:60,algorithm:patience",
    errorbells = true,
    listchars = "tab:>·,nbsp:+,trail:·,extends:→,precedes:←",
    shiftwidth = 4,
    tabstop = 4,
    visualbell = true,
    shell = '"C:\\Program Files\\PowerShell\\7\\pwsh.exe"',
    shellcmdflag = "-NoLogo -Command",
    shellquote = "\\",
    shellxquote = "",
}

local function isempty(s)
    return s == nil or s == ""
end
local function use_if_defined(val, fallback)
    return val ~= nil and val or fallback
end

vim.g.lazyvim_eslint_auto_format = true

-- custom python provider
local conda_prefix = os.getenv("CONDA_PREFIX")
if not isempty(conda_prefix) then
    vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, conda_prefix .. "/bin/python")
    vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, conda_prefix .. "/bin/python")
else
    vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, "python")
    vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, "python3")
end
for name, value in pairs(global_local) do
    vim.api.nvim_set_option_value(name, value, {})
end

if vim.g.neovide then
    vim.o.guifont = "RobotoMono Nerd Font Mono:h11"
    -- vim.g.neovide_cursor_animation_length = 0
end
