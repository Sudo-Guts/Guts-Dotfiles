return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        require("telescope").setup({})
        local builtin = require("telescope.builtin")
        vim.keymap.set('n', '<space>f', builtin.find_files, { noremap = true , silent = true })
        vim.keymap.set('n', '<space>g', builtin.live_grep, { noremap = true , silent = true })
        vim.keymap.set('n', '<space>b', builtin.buffers, { noremap = true , silent = true })
        vim.keymap.set('n', '<space>h', builtin.help_tags, { noremap = true , silent = true }) 
    end
}
