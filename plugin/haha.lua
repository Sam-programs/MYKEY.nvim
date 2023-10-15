local   _old_keymap_set = vim.keymap.set
local   _old_keymap_set_buf = vim.api.nvim_buf_set_keymap

local autocmd_handler = function(mode, mapkey, func, opts)
   vim.cmd('do <nomodeline> User _keymap')
end

local autocmd_handler_buf = function(_,mode, mapkey, func, opts)
   autocmd_handler(mode,mapkey,func,opts)
end

local mykey = '<cr>'
vim.api.nvim_create_autocmd({"User"}, {
   pattern = "_keymap",
   callback = function()
         _old_keymap_set_buf(0,'i',mykey,mykey,{})
   end,
})

vim.keymap.set = function(...)
   autocmd_handler(...)
   _old_keymap_set(...)
end

vim.api.nvim_buf_set_keymap = function(...)
   autocmd_handler_buf(...)
   _old_keymap_set_buf(...)
end
