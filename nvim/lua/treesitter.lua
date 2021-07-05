local M = {}

M.config = function()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            "bash",
            "lua",
            "json",
            "python",
            "rust",
            "cpp",
            "c",
            "verilog"
        },
        highlight = {
            enable = true,
            use_languagetree = true
        },
    }

    -- vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]

end


return M
