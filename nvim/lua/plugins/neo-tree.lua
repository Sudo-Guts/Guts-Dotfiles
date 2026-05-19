return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "󰜌",
            },
            modified = {
                symbol = "󱨍",
                highlight = "NeoTreeModified",
            },
            git_status = {
                symbols = {
                    added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                    modified  = "󱨍", -- or "", but this is redundant info if you use git_status_colors on the name
                    deleted   = "✖",-- this can only be used in the git_status source
                    renamed   = "󰁕",-- this can only be used in the git_status source
                    -- Status type
                    untracked = "",
                    ignored   = "",
                    unstaged  = "󰄱",
                    staged    = "",
                    conflict  = "",
                }
            },
        })
    end
}
