-- Fix para el doble Enter/Delete en NVIM 0.12 + Kitty
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function() 
    io.stdout:write("\027[>1u") 
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function() 
    io.stdout:write("\027[<1u") 
  end,
})

