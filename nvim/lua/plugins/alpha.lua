return{
    "goolord/alpha-nvim",
    config = function()
        local dashboard = require("alpha.themes.dashboard")
        local alpha = require("alpha")

        dashboard.section.header.val = {
            "  ▄████     █    ██    ▄▄▄█████▓     ██████ ",
            " ██▒ ▀█▒    ██  ▓██▒   ▓  ██▒ ▓▒   ▒██    ▒ ",
            "▒██░▄▄▄░   ▓██  ▒██░   ▒ ▓██░ ▒░   ░ ▓██▄   ",
            "░▓█  ██▓   ▓▓█  ░██░   ░ ▓██▓ ░      ▒   ██▒",
            "░▒▓███▀▒   ▒▒█████▓      ▒██▒ ░    ▒██████▒▒",
            " ░▒   ▒    ░▒▓▒ ▒ ▒      ▒ ░░      ▒ ▒▓▒ ▒ ░",
            "  ░   ░    ░░▒░ ░ ░        ░       ░ ░▒  ░ ░",
            "░ ░   ░     ░░░ ░ ░      ░         ░  ░  ░  ",
            "      ░       ░                          ░  ",
        }

        dashboard.section.header.opts.hl = "AlphaHeaderLabel"

        -- Menu
        dashboard.section.buttons.val = {
            { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
            dashboard.button("g", "󱎸  Find text", "<space>g"),
            dashboard.button('f', '  Find file', '<space>f'),
            dashboard.button('t', '󰙅  Tree', '<space>t'),
            dashboard.button('u', '  Update plugins', ':Lazy update<CR>'),
            dashboard.button('s', '  Save', ':x!<CR>'),
        }

        alpha.setup(dashboard.opts)

    end
}
