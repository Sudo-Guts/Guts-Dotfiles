return{
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        require("which-key").setup({
            layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
                align = "center", -- align columns left, center or right
            },
            win = {
                border = "single", -- none, single, double, shadow
                position = "bottom", -- bottom, top
                margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
                padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
                winblend = 0,
            },
            keys = {
                Up = "󰸸 ",
                Down = "󰸴 ",
                Left = "󰸵 ",
                Right = "󰸷 ",
                C = "󰘴 ",
                M = "󰘵 ",
                D = "󰘳 ",
                S = "󰘶 ",
                CR = "󰌑 ",
                Esc = "󱊷 ",
                ScrollWheelDown = "󱕐 ",
                ScrollWheelUp = "󱕑 ",
                NL = "󰌑 ",
                BS = "󰁮",
                Space = "󱁐 ",
                Tab = "󰌒 ",
                F1 = "󱊫",
                F2 = "󱊬",
                F3 = "󱊭",
                F4 = "󱊮",
                F5 = "󱊯",
                F6 = "󱊰",
                F7 = "󱊱",
                F8 = "󱊲",
                F9 = "󱊳",
                F10 = "󱊴",
                F11 = "󱊵",
                F12 = "󱊶",
            },
            icons = {
                breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                separator = " ", -- symbol used between a key and it's label
                group = "+", -- symbol prepended to a group
            },
            preset = "modern",
            { "<leader>f1", hidden = true },
            { "<leader>fn", desc = "New File" },
        })
    end
}
