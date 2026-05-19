return{
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                themable = true,
                numbers = "none",
                modified_icon = ' ',
                buffer_close_icon ='󰛉 ',
                close_icon = '',
                left_trunc_marker = '',
                right_trunc_marker = '',
                separator_style = '',
                tab_size = 18,
                color_icons = true,
                indicator = {
                    icon = '  󰅟  ',
                    style = 'icon',
                },
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "󱘎 ",
                        text_align = "center",
                        separator = true,
                    }
                },
            }
        })
    end,
    diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or ""
        return " " .. icon .. count
    end
}
