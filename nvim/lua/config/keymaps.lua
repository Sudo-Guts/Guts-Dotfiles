local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')

-- Select all
    keymap.set( 'n', '<C-a>', 'gg<S-v>G')
    
-- Save and exit
--  keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
    keymap.set( 'n' , '<space>s' , ':x!<CR>' , opts )
    
-- Scroll

    keymap.set( 'n' , '<space>,' , '<C-w>h' , {} )
    keymap.set( 'n' , '<space>.' , '<C-w>l' , {} )
    
-- /~~~>[ Neo-Tree ]<----------------------------\

    keymap.set( 'n' , '<space>t' , ':Neotree<CR>' , opts )
    
-- /~~~>[ Telescope ]<---------------------------\ 

    keymap.set( 'n', '<space>f' , builtin.find_files , {} )
    keymap.set( 'n', '<space>g' , builtin.live_grep , {} )
    keymap.set( 'n', '<space>b' , builtin.buffers , {} )
    keymap.set( 'n', '<space>h' , builtin.help_tags , {} )
    
-- /~~~>[ Bufferline ]<--------------------------\

    keymap.set( 'n' , '<tab>,' , ':tabprev<Return>' , opts )
    keymap.set( 'n' , '<tab>.' , ':tabnext<Return>' , opts ) 
